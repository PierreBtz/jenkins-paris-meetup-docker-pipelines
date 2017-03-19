package eu.beitz;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by Pierre Btz on 19/03/17.
 */
@PropertySource(value = "classpath:git.properties")
@RestController
public class VersionController {

    @Value("${git.commit.id.abbrev}")
    private String commit;

    @RequestMapping("/commit")
    public String commit() {
        return commit;
    }
}