package com.tourcan.att.model;

import java.util.List;

import org.hibernate.Session;

import hibernate.util.HibernateUtil;

public class AttDAO implements AttDAO_interface {

	@Override
	public void insert(AttVO attVO) {
	
	}

	@Override
	public void update(AttVO attVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(Integer attId) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			AttVO attVO=new AttVO();
			attVO.setAtt_id(attId);
			session.delete(attVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}

	@Override
	public AttVO findById(Integer att_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<AttVO> findByName(String att_name) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<AttVO> getAll() {
		// TODO Auto-generated method stub
		return null;
	}

}
