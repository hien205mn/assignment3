<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="domain.User" %>
<%@ page import="dal.CartDAO" %>
<!-- Navbar start -->
<div class="container-fluid fixed-top">
    <div class="container px-0">
        <nav class="navbar navbar-light bg-white navbar-expand-xl">
            <a href="/phoneshop/homepage" class="navbar-brand">
                <h1 class="text-primary display-6">Phoneshop</h1>
            </a>
            <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarCollapse">
                <span class="fa fa-bars text-primary"></span>
            </button>
            <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                <div class="navbar-nav mx-auto">
                    <a href="/phoneshop/homepage" class="nav-item nav-link active">Home</a>
                    <a href="/phoneshop/products" class="nav-item nav-link">Products</a>
                    <a href="/phoneshop/contact" class="nav-item nav-link active">Contact</a>
                </div>

                <div class="d-flex m-3 me-0">
                    <button
                        class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white me-4"
                        data-bs-toggle="modal" data-bs-target="#searchModal">
                        <i class="fas fa-search text-primary"></i>
                    </button>

                    <a href="/phoneshop/cart" class="position-relative me-4 my-auto">
                        <i class="fa fa-shopping-bag fa-2x"></i>
                        <span class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
                              style="top: -5px; left: 15px; height: 20px; min-width: 20px;">
                            <%
        if (session.getAttribute("user") != null) {
        User user = (User) session.getAttribute("user");
            CartDAO cartDAO = new CartDAO();
        int totalQuantity = cartDAO.getTotalQuantityOfProductInCart(user.getId());
        
        out.print(totalQuantity);  
        } else {
            out.print(0);
        }
                            %>
                        </span>
                    </a>

                    <!-- Điều kiện kiểm tra user -->
                    <% if (session.getAttribute("user") != null) { %>
                    <!-- Nếu người dùng đã đăng nhập -->
                    <div class="dropdown my-auto">
                        <a href="#" class="dropdown-toggle" id="dropdownUserMenu" data-bs-toggle="dropdown" aria-expanded="false">
                            Welcom, ${sessionScope.user.lastName}
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="dropdownUserMenu">
                            <li><a class="dropdown-item" href="/phoneshop/order">My order </a></li>
                            <li><a class="dropdown-item" href="/phoneshop/profile">Profile </a></li>
                            <li><a class="dropdown-item" href="/phoneshop/logout">Log out</a></li>
                        </ul>
                    </div>
                    <% } else { %>
                    <!-- Nếu người dùng chưa đăng nhập -->
                    <a href="/phoneshop/login" class="my-auto">Login</a>
                    <a href="/phoneshop/register" class="my-auto ms-3">Sign up</a>
                    <% } %>
                </div>


            </div>
        </nav>
    </div>
</div>
<!-- Navbar End -->