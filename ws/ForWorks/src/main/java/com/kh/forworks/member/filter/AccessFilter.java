package com.kh.forworks.member.filter;

import static org.springframework.util.ObjectUtils.isEmpty;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.util.PatternMatchUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AccessFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest httpRequest = (HttpServletRequest) request;
	    String requestURI = httpRequest.getRequestURI();
	    String rootPath = httpRequest.getServletContext().getContextPath();
	    
	    String[] exceptList = {
	    		rootPath + "/", 
	    		rootPath + "/login", 
	    		rootPath + "/join", 
	    		rootPath + "/logout", 
	    		rootPath + "/idCheck", 
	    		rootPath + "/findId", 
	    		rootPath + "/findPwd", 
	    		rootPath + "/foradmin", 
	    		rootPath + "/foradmin/login",
	    		rootPath + "/resources/**"};
	    String adminPage = rootPath + "/foradmin/**";
	    
	    HttpServletResponse httpResponse = (HttpServletResponse) response;
	    
	    try {
	      if (!PatternMatchUtils.simpleMatch(exceptList, requestURI)) {
	        HttpSession session = httpRequest.getSession(false);
	        if (PatternMatchUtils.simpleMatch(adminPage, requestURI)) {
	        	if (isEmpty(session) || isEmpty(session.getAttribute("chiefAdmin"))) {
	        	  log.info("비인가 관리자 페이지 접근 {}", requestURI);
	  	          httpResponse.sendRedirect(rootPath + "/foradmin");
	  	          return;
	  	        }
	        } else if (isEmpty(session) || isEmpty(session.getAttribute("loginMember"))) {
	          httpResponse.sendRedirect(rootPath + "/login");
	          return;
	        }
	      }
	      chain.doFilter(request, response);
	    } catch (Exception e) {
	      throw e;
	    }
		
	}

}
