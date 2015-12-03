package com.springapp.mvc;

import entity.Point;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@PropertySource("classpath:settings.txt")
public class MapController {

    @Autowired
    Environment environment;

    @RequestMapping(value = "/map", method = RequestMethod.GET)
    public String start(ModelMap model) {
        model.addAttribute("apiKey", environment.getProperty("apiKey"));
        return "map";
    }

    @RequestMapping(value = "/map", method = RequestMethod.POST)
    @ResponseBody
    public Object map(ModelMap model, @RequestParam String pointName, @RequestParam String pointDesc) {
        System.out.println(pointName + " : " + pointDesc);
        //search in api
        Point point = new Point();
        point.setDescription(pointName);
        point.setLatitude(47.163);
        point.setLongitude(10.644);
        return point;
    }


}
