<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page import="java.util.List" %>
<%@ page import="dal.ProductDAO" %>
<%@ page import="domain.Product" %>

<%
    // Fallback: nếu chưa có dữ liệu do servlet set, tự lấy từ DAO
    List<Product> _featured = (List<Product>) request.getAttribute("products");
    List<Product> _cheap = (List<Product>) request.getAttribute("productss");

    ProductDAO _dao = null;
    if (_featured == null || _featured.isEmpty() || _cheap == null || _cheap.isEmpty()) {
        _dao = new ProductDAO();
    }
    // Yêu cầu của bạn: "ngay khi bắt đầu hiển thị tất cả sản phẩm"
    // -> Mình cho phần Feature products hiển thị TẤT CẢ sản phẩm (getAllProducts)
    if (_featured == null || _featured.isEmpty()) {
        _featured = _dao.getAllProducts(); // hiển thị tất cả ngay từ đầu
        request.setAttribute("products", _featured);
    }
    // Phần Best price: lấy 8 sản phẩm rẻ nhất (giữ đúng ý nghĩa block "Best price")
    if (_cheap == null || _cheap.isEmpty()) {
        _cheap = _dao.getTop8ProductsCheapest();
        request.setAttribute("productss", _cheap);
    }
%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phone Shop</title>

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
        rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
          rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="${pageContext.request.contextPath}/resources/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <!-- FIX: dùng contextPath cho owlcarousel -->
    <link href="${pageContext.request.contextPath}/resources/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="${pageContext.request.contextPath}/resources/client/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="${pageContext.request.contextPath}/resources/client/css/style.css" rel="stylesheet">
</head>

<body>
    <!-- Spinner Start -->
    <div id="spinner"
         class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <!-- Spinner End -->

    <jsp:include page="../layout/header.jsp" />

    <!-- Modal Search Start -->
    <jsp:include page="../layout/search.jsp" />
    <!-- Modal Search End -->

    <jsp:include page="../layout/banner.jsp" />

    <!-- Fruits Shop Start (Feature products = ALL products) -->
    <div class="container-fluid fruite py-5">
        <div class="container py-5">
            <div class="tab-class text-center">
                <div class="row g-4">
                    <div class="col-lg-4 text-start">
                        <h1>Feature products</h1>
                    </div>
                    <div class="col-lg-8 text-end">
                        <ul class="nav nav-pills d-inline-flex text-center mb-5">
                            <li class="nav-item">
                                <a class="d-flex m-2 py-2 bg-light rounded-pill active"
                                   href="/phoneshop/products">
                                    <span class="text-dark" style="width: 130px;">All Products</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="tab-content">
                    <div id="tab-1" class="tab-pane fade show p-0 active">
                        <div class="row g-4">
                            <div class="col-lg-12">
                                <div class="row g-4">
                                    <c:forEach items="${requestScope.products}" var="product">
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="${pageContext.request.contextPath}/resources/admin/images/product/${product.image}"
                                                         class="img-fluid w-100 h-50 rounded-top" alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                     style="top: 10px; left: 10px;">Phone</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4 style="font-size: 15px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                                        <a href="/phoneshop/product?id=${product.id}">
                                                            ${product.name}
                                                        </a>
                                                    </h4>
                                                    <p style="font-size: 13px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                                        ${product.shortDesc}
                                                    </p>
                                                    <div class="d-flex flex-lg-wrap"></div>
                                                    <p class="text-dark fw-bold mb-3"
                                                       style="font-size: 15px; text-align: center; width: 100%;">
                                                        <fmt:formatNumber type="number" value="${product.price}" maxFractionDigits="2" /> đ
                                                    </p>

                                                    <!-- Form Add to cart -->
                                                    <form action="cart" method="post" class="d-flex justify-content-center">
                                                        <input type="hidden" name="productId" value="${product.id}">
                                                        <input type="hidden" name="quantity" value="1">
                                                        <input type="hidden" name="returnUrl" value="${requestScope['jakarta.servlet.forward.request_uri']}?${pageContext.request.queryString}">
                                                        <c:choose>
                                                            <c:when test="${product.quantity < 1}">
                                                                <button type="button" class="mx-auto btn border border-secondary rounded-pill px-3 text-muted" disabled>
                                                                    <i class="fa fa-shopping-bag me-2 text-muted"></i> Sold out
                                                                </button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button type="submit" class="mx-auto btn border border-secondary rounded-pill px-3 text-primary">
                                                                    <i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart
                                                                </button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div> <!-- tab-1 -->
                </div>
            </div>
        </div>
    </div>

    <%
        String message = (String) session.getAttribute("message");
        if (message != null) {
    %>
    <div id="alertMessage" class="alert alert-success text-center" style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 9999; width: 50%;" role="alert">
        <%= message %>
    </div>
    <script>
        setTimeout(function () {
            document.getElementById("alertMessage").style.display = 'none';
        }, 2000);
    </script>
    <%
        session.removeAttribute("message");
        }
    %>

    <!-- Best price -->
    <div class="container-fluid fruite py-5">
        <div class="container py-5">
            <div class="tab-class text-center">
                <div class="row g-4">
                    <div class="col-lg-4 text-start">
                        <h1>Best price</h1>
                    </div>
                    <div class="col-lg-8 text-end">
                        <ul class="nav nav-pills d-inline-flex text-center mb-5">
                            <li class="nav-item">
                                <a class="d-flex m-2 py-2 bg-light rounded-pill active"
                                   href="/phoneshop/products">
                                    <span class="text-dark" style="width: 130px;">All Products</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="tab-content">
                    <div id="tab-1" class="tab-pane fade show p-0 active">
                        <div class="row g-4">
                            <div class="col-lg-12">
                                <div class="row g-4">
                                    <c:forEach items="${requestScope.productss}" var="product">
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="${pageContext.request.contextPath}/resources/admin/images/product/${product.image}"
                                                         class="img-fluid w-100 h-50 rounded-top" alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                     style="top: 10px; left: 10px;">Phone</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4 style="font-size: 15px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                                        <a href="/phoneshop/product?id=${product.id}">
                                                            ${product.name}
                                                        </a>
                                                    </h4>
                                                    <p style="font-size: 13px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                                        ${product.shortDesc}
                                                    </p>
                                                    <div class="d-flex flex-lg-wrap"></div>
                                                    <p class="text-dark fw-bold mb-3"
                                                       style="font-size: 15px; text-align: center; width: 100%;">
                                                        <fmt:formatNumber type="number" value="${product.price}" maxFractionDigits="2" /> đ
                                                    </p>

                                                    <form action="cart" method="post" class="d-flex justify-content-center">
                                                        <input type="hidden" name="productId" value="${product.id}">
                                                        <input type="hidden" name="quantity" value="1">
                                                        <input type="hidden" name="returnUrl" value="${requestScope['jakarta.servlet.forward.request_uri']}?${pageContext.request.queryString}">
                                                        <c:choose>
                                                            <c:when test="${product.quantity < 1}">
                                                                <button type="button" class="mx-auto btn border border-secondary rounded-pill px-3 text-muted" disabled>
                                                                    <i class="fa fa-shopping-bag me-2 text-muted"></i> Sold out
                                                                </button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button type="submit" class="mx-auto btn border border-secondary rounded-pill px-3 text-primary">
                                                                    <i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart
                                                                </button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div> <!-- tab-1 -->
                </div>
            </div>
        </div>
    </div>
    <!-- Fruits Shop End-->

    <jsp:include page="../layout/feature.jsp" />
    <jsp:include page="../layout/footer.jsp" />

    <!-- Back to Top -->
    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top">
        <i class="fa fa-arrow-up"></i>
    </a>

    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- FIX: dùng contextPath cho easing + waypoints + lightbox + owlcarousel -->
    <script src="${pageContext.request.contextPath}/resources/client/lib/easing/easing.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/client/lib/waypoints/waypoints.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/client/lib/lightbox/js/lightbox.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/client/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="${pageContext.request.contextPath}/resources/client/js/main.js"></script>
</body>
</html>
