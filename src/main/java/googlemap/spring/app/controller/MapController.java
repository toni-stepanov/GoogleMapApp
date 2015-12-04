package googlemap.spring.app.controller;

import googlemap.spring.app.entity.Point;
import googlemap.spring.app.service.PointService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Random;

@Controller
@PropertySource("classpath:settings.txt")
public class MapController {

    @Autowired
    Environment environment;

    @Autowired
    PointService pointService;

    @RequestMapping(value = "/mapgoogle", method = RequestMethod.GET)
    public String start(ModelMap model) {
        model.addAttribute("apiKey", environment.getProperty("apiKey"));
        return "map";
    }

    @RequestMapping(value = "/map", method = RequestMethod.POST)
    @ResponseBody
    public Object map(ModelMap model, @RequestParam String pointName, @RequestParam String pointDesc) {
        //search in api
        Point point = new Point();
        point.setDescription(pointName);
        Random random = new Random();
        Integer rnd = random.nextInt(100);
        point.setLatitude(rnd);
        point.setLongitude(rnd + random.nextInt(30));
        return pointService.save(point);
    }


}
