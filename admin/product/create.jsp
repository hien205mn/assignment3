<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="Phoneshop" />
        <meta name="author" content="Group 3" />
        <title>Dashboard - Create Product</title>
        <script src="https://cdn.ckeditor.com/4.16.0/standard/ckeditor.js"></script>
        <link href="${pageContext.request.contextPath}/resources/admin/css/styles.css" rel="stylesheet" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

        <script>
            $(document).ready(() => {
                const avatarFile = $("#avatarFile");
                avatarFile.change(function (e) {
                    const imgURL = URL.createObjectURL(e.target.files[0]);
                    $("#avatarPreview").attr("src", imgURL);
                    $("#avatarPreview").css({"display": "block"});
                });
            });

            function removeImage() {
                const avatarFile = document.getElementById('avatarFile');
                const avatarPreview = document.getElementById('avatarPreview');

                // Reset file input
                avatarFile.value = '';

                // Hide the preview image
                avatarPreview.style.display = 'none';
                avatarPreview.src = '';
            }
        </script>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
        crossorigin="anonymous"></script>
    </head>

    <body class="sb-nav-fixed">
        <jsp:include page="../layout/header.jsp" />
        <div id="layoutSidenav">
            <jsp:include page="../layout/sidebar.jsp" />
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Manage Products</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active"><a href="/phoneshop/admin">Dashboard</a> </li>
                            <li class="breadcrumb-item active"><a href="/phoneshop/admin/product">Products</a> </li>
                            <li class="breadcrumb-item active">Create Product</li>
                        </ol>
                        <div class="mt-5">
                            <div class="row">
                                <div class="col-md-6 col-12 mx-auto">
                                    <h3>Create a product</h3>
                                    <hr />
                                    <form method="post" action="create"
                                          class="row" enctype="multipart/form-data">

                                        <!-- Name -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Name:</label>
                                            <input type="text" class="form-control" name="name" />
                                        </div>

                                        <!-- Price -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Price:</label>                                            
                                            <div class="input-group">
                                                <input type="number" class="form-control" name="price" value="0.0" min="0" step="any" />
                                                <span class="input-group-text">VNĐ</span>
                                            </div>
                                        </div>

                                        <!-- Quantity -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Quantity:</label>
                                            <input type="number" class="form-control" name="quantity" value="0" min="0" step="1" />
                                        </div>

                                        <!-- Sold -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Sold:</label>
                                            <input type="number" class="form-control" name="sold" value="0" min="0" step="1"/>
                                        </div>

                                        <!-- Factory -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Factory:</label>
                                            <select class="form-select" name="factory">
                                                <option value="Apple">Apple</option>
                                                <option value="Asus">Sony</option>
                                                <option value="Dell">Google</option>
                                                <option value="Lenovo">Vivo</option>
                                                <option value="Msi">Xiaomi</option>
                                                <option value="Acer">Oppo</option>
                                                <option value="HP">Samsung</option>
                                                <option value="LG">Nokia</option>
                                            </select>
                                        </div>

                                        <!-- Chip Category -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Chip Category:</label>
                                            <select class="form-select" name="chipCategory">

                                                <option value="Snapdragon">Snapdragon</option>
                                                <option value="MediaTek">MediaTek</option>
                                                <option value="Apple Bionic">Apple Bionic</option>
                                                <option value="Google Tensor">Google Tensor</option>
                                            </select>
                                        </div>

                                        <!-- chip-->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Chip:</label>
                                            <input type="text" class="form-control" name="chip" />
                                        </div>

                                        <!-- RAM -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">RAM:</label>
                                            <div class="input-group">
                                                <input type="number" class="form-control" name="ram" placeholder="Enter RAM size" />
                                                <span class="input-group-text">GB</span>
                                            </div>
                                        </div>

                                        <!-- MEM -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">MEM:</label>
                                            <input type="text" class="form-control" name="mem" />
                                        </div>

                                        <!-- Screen -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Screen:</label>
                                            <input type="text" class="form-control" name="screen" />
                                        </div>

                                        <!-- Camera -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Camera:</label>
                                            <input type="text" class="form-control" name="camera" />
                                        </div>

                                        <!-- Target -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Target:</label>
                                            <select class="form-select" name="target">
                                                <option value="CHOI_GAME">CHƠI GAME</option>
                                                <option value="HANG_NGAY">HẰNG NGÀY</option>
                                                <option value="NHIEP_ANH">NHIẾP ẢNH</option>
                                                <option value="GON_NHE">GỌN NHẸ</option>
                                                <option value="CAO_CAP">CAO CẤP</option>
                                                
                                            </select>
                                        </div>

                                        <!-- Short Description -->
                                        <div class="mb-3">
                                            <label class="form-label">Short description:</label>
                                            <input type="text" class="form-control" name="shortDesc" />
                                        </div>

                                        <!-- Detail Description -->
                                        <div class="mb-3">
                                            <label class="form-label">Detail description:</label>
                                            <textarea class="form-control" id="detailDesc" name="detailDesc" rows="3"
                                                      style="resize: vertical; max-height: 200px;"></textarea>
                                            <script>
            CKEDITOR.replace('detailDesc'); // Kích hoạt CKEditor cho textarea
                                            </script>     
                                        </div>

                                        <!-- Images -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label for="avatarFile" class="form-label">Images:</label>
                                            <input class="form-control" type="file" id="avatarFile"
                                                   accept=".png, .jpg, .jpeg" name="productFile" onchange="previewImage(event)" />
                                        </div>

                                        <!-- Storage -->
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Storage:</label>
                                            <select class="form-select" name="storage">
                                                <option value="1">YES</option>
                                                <option value="0">NO</option>

                                            </select>
                                        </div>

                                        <div class="col-12 mb-3">
                                            <img style="max-height: 250px; display: none;" alt="avatar preview" id="avatarPreview" />
                                        </div>

                                        <!-- Remove Image Button -->
                                        <div class="col-12 mb-3">
                                            <button type="button" class="btn btn-success" onclick="removeImage()">Remove Image</button>
                                        </div>

                                        <!-- Submit Button -->
                                        <div class="col-12 mb-5">
                                            <button type="submit" class="btn btn-primary">Create</button>
                                        </div>

                                    </form>

                                </div>

                            </div>

                        </div>
                    </div>
                </main>
                <jsp:include page="../layout/footer.jsp" />
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/resources/admin/js/scripts.js"></script>

    </body>

</html>