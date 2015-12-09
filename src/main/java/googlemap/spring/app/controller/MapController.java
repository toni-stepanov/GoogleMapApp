package googlemap.spring.app.controller;

import googlemap.spring.app.entity.Point;
import googlemap.spring.app.service.PointService;
import org.apache.commons.io.IOUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.List;

@Controller
@PropertySource("classpath:settings.txt")
public class MapController {

    Logger logger = LoggerFactory.getLogger(MapController.class);

    @Autowired
    Environment environment;

    @Autowired
    PointService pointService;

    @RequestMapping(value = "/mapgoogle", method = RequestMethod.GET)
    public String start(ModelMap model) {
        model.addAttribute("apiKey", environment.getProperty("mapKey"));
        List<Point> points = pointService.findAll();
        model.addAttribute("points", points);
        return "map";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public Object map(ModelMap model, @RequestParam String pointName, @RequestParam String pointDesc) throws IOException {
        requestToGoogleMapApi(pointDesc);
        Point newPoint = requestToGoogleMapApi(pointDesc);
        newPoint.setDescription(pointName);
        Point save = pointService.save(newPoint);
        logger.info("Added new Point: " + save.toString());
        return save;
    }

    public Point requestToGoogleMapApi(String description) throws IOException {
        JSONObject response = sendRequest(description);
        JSONArray results = response.getJSONArray("results");
        String status = (String) response.get("status");
        if (!"OK".equals(status)) {
            return null;
        }
        JSONObject result = results.getJSONObject(0);
        JSONObject geometry = (JSONObject) result.get("geometry");
        JSONObject location = geometry.getJSONObject("location");

        Point newPoint = new Point();
        newPoint.setAddress((String) result.get("formatted_address"));
        newPoint.setLatitude((Double) location.get("lat"));
        newPoint.setLongitude((Double) location.get("lng"));
        return newPoint;
    }

    public JSONObject sendRequest(String description) throws IOException {
        HttpClient httpclient = new DefaultHttpClient();
        String geocodingRequest = environment.getProperty("geocodingRequest");
        String description1 = geocodingRequest.replace("DESCRIPTION", URLEncoder.encode(description, "UTF-8"));
        HttpGet request = new HttpGet(description1);
        request.addHeader("content-type", "application/json");
        HttpResponse resp = httpclient.execute(request);
        InputStream inputStream = resp.getEntity().getContent();
        String res = IOUtils.toString(inputStream, "UTF-8");
        JSONObject response = new JSONObject(res);
        return response;
    }


}
