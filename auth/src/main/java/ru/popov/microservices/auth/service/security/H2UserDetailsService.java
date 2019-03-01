package ru.popov.microservices.auth.service.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import ru.popov.microservices.auth.domain.User;
import ru.popov.microservices.auth.repository.UserRepository;

/**
 * Created by imrenagi on 5/8/17.
 */
@Service("userDetailsService")
public class H2UserDetailsService implements UserDetailsService {

    private final Logger log = LoggerFactory.getLogger(H2UserDetailsService.class);

    @Autowired
    private UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        User user = userRepository.findByUsername(s);
        log.info("user is found! -> " + user.getUsername());

        if (user == null) {
            log.info("user is not found!");
            throw new UsernameNotFoundException(s);
        }
        return user;
    }
}
