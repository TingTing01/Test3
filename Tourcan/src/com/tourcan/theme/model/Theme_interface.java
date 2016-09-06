package com.tourcan.theme.model;

import java.util.List;

import com.tourcan.att.model.AttVO;

public interface Theme_interface  {
	public void insert(ThemeVO themeVO);
	public void update(ThemeVO themeVO);
	public void delete(Integer theme_id);
	public ThemeVO findById(Integer theme_id);
	public List<ThemeVO> findByTopic(String theme_topic);
	public List<ThemeVO> getAll();
}
