package ru.popov.microservices.auth.repository;


import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.popov.microservices.auth.domain.Permission;

/**
 * Created by imrenagi on 5/12/17.
 */
@Repository
public interface PermissionRepository extends CrudRepository<Permission, Long> {
    Permission findByName(String name);
}
