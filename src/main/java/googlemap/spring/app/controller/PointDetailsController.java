package googlemap.spring.app.controller;

import googlemap.spring.app.entity.Point;
import googlemap.spring.app.service.PointService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PointDetailsController {

    @Autowired
    PointService pointService;

    @Autowired
    Environment environment;

    @RequestMapping(value = "point/{id}")
    public String pointDetails(ModelMap model, @PathVariable Integer id) {
        Point point = pointService.findById(id);
        model.addAttribute("point", point);
        model.addAttribute("apiKey", environment.getProperty("mapKey"));
        return "point";
    }

}
