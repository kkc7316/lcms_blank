package com.svw.lcms.framework.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class SessionSupport {
    /**
     * sessionFactory
     */
    @Autowired
    @Qualifier("sessionFactory")
    public SessionFactory sessionFactory;

    /**
     * 
     * <p>
     * Description: getCurrentSessionFactory
     * </p>
     * 
     * @return SessionFactory
     */
    public SessionFactory getCurrentSessionFactory() {
        return this.sessionFactory;
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    /**
     * <p>
     * Description: getCurrentSession
     * </p>
     * 
     * @return Session
     */
    public Session getCurrentSession() {
        return this.sessionFactory.getCurrentSession();
    }
    
    
}
