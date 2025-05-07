package com.mybudget.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")  // Filtre toutes les URLs
public class AuthFilter implements Filter {

    private static final String[] PUBLIC_PATHS = {
            "/login",
            "/login.jsp",
            "/css/",
            "/js/",
            "/images/"
    };

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());

        // Vérifie si la ressource est publique
        for (String publicPath : PUBLIC_PATHS) {
            if (path.startsWith(publicPath)) {
                chain.doFilter(request, response);
                return;
            }
        }

        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("estConnecte") != null);

        if (isLoggedIn) {
            chain.doFilter(request, response);
        } else {
            // Stocke la page demandée pour redirection après login
            String redirectAfterLogin = httpRequest.getRequestURI();
            if (httpRequest.getQueryString() != null) {
                redirectAfterLogin += "?" + httpRequest.getQueryString();
            }
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login?from=" +
                    java.net.URLEncoder.encode(redirectAfterLogin, "UTF-8"));
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialisation si nécessaire
    }

    @Override
    public void destroy() {
        // Nettoyage si nécessaire
    }
}
