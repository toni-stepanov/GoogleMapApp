package googlemap.spring.app.repository;

import googlemap.spring.app.entity.Point;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PointRepository extends JpaRepository<Point, Integer> {
}
