package com.tourcan.resp.model;

import java.util.List;

public class RespService {

	private Resp_interface dao;

	public RespService() {
		dao = new RespDAO();
	}

	public void insert(RespVO respVO) {
		dao.insert(respVO);
	}

	public void update(RespVO respVO) {
		dao.update(respVO);
	}

	public List<RespVO> findByTopic(String resp_topic) {
		return dao.findByTopic(resp_topic);
	}

	public void delete(Integer resp_id) {
		dao.delete(resp_id);
	}

	public List<RespVO> findByThID(Integer theme_id) {
		return dao.findByThID(theme_id);
	}

	public RespVO findById(Integer resp_id) {
		return dao.findById(resp_id);
	}

	public boolean deleteByThemeID(Integer theme_id) {
		List<RespVO> reslist = null;
		try {
			reslist = dao.findByThID(theme_id);
			for (RespVO respVO : reslist) {
				Integer respID = respVO.getResp_id();
				dao.delete(respID);
			}
			return true;
		} catch (Exception e) {
			return false;
		}

	}

}
