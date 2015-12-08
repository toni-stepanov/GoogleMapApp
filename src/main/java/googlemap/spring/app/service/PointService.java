package googlemap.spring.app.service;

import googlemap.spring.app.entity.Point;
import googlemap.spring.app.repository.PointRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class PointService {

    @Autowired
    PointRepository pointRepository;

    public Point save(Point point) {
        return pointRepository.save(point);
    }
}
