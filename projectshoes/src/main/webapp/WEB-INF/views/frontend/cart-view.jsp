<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- directive của JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="/WEB-INF/views/frontend/layout/css.jsp"></jsp:include>
    <title>${title }</title>
</head>
<body>
    <jsp:include page="/WEB-INF/views/frontend/layout/header.jsp"></jsp:include>
    <nav>
        <div class="bread-crumb">
            <div class="container">
                <div class="nd-main-title-breadcrumb text-center">
                    Giỏ hàng
                </div>
                <ul class="breadcrumb">
                    <li class="home" itemprop="itemListElement">
                        <a href="${classpath }/index" itemprop="item" title="Trang chủ">
                            <span itemprop="name">Trang Chủ</span>
                        </a>
                    </li>
                    <li itemprop="itemListElement">
                        <strong itemprop="name">Giỏ hàng</strong>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <main>
        <div class="main-cart-page main-container col1-layout">
            <div class="main container cartpcstyle">
                <div class="wrap_background_aside margin-bottom-40">
                    <div class="header-cart">
                        <div class="title-block-page">
                            <h1 class="title_cart">
                                <span>Giỏ hàng của bạn</span>
                            </h1>
                        </div>
                    </div>
                    <c:choose>
                    <c:when test="${totalCartproducts > 0}">
                    <div class="cart-page d-xl-block">
                        <div class="drawer__inner">
                            <div class="CartPageContainer">
                                <form action="/cart" method="post" class="cart ajaxcart cartpage">
                                    <div class="cart-header-info">
                                        <div>Thông tin sản phẩm</div>
                                        <div>Đơn giá</div>
                                        <div>Số lượng</div>
                                        <div>Thành tiền</div>
                                    </div>
                                    <c:forEach var="item" items="${cart.productCarts }">
                                    <div class="ajaxcart__inner ajaxcart__inner--has-fixed-footer cart_body items">
                                        <div class="ajaxcart__row">
                                            <div class="ajaxcart__product cart_product">
                                                <a href="" class="ajaxcart__product-image cart_image" title="Nike">
                                                    <img src="${classpath}/FileUploads/${item.avatar}" alt="">
                                                </a>
                                                <div class="grid__item cart_info">
                                                    <div class="ajaxcart__product-name-wrapper cart_name">
                                                        <a href="" class="ajaxcart__product-name h4" >${item.productName }</a>
                                                        <span class="ajaxcart__product-meta variant-title">Đen / 40</span>
                                                        <a href="${classpath }/product-cart-delete/${item.productId}" class="cart__btn-remove remove-item-cart ajaxifyCart--remove">Xóa</a>
                                                    </div>
                                                    <div class="grid">
                                                        <div class="grid__item one-half text-right cart_prices">
                                                            <span class="cart-price"><fmt:formatNumber value="${item.price }" minFractionDigits="0"></fmt:formatNumber> </span>
                                                        </div>
                                                    </div>
                                                    <div class="grid">
                                                        <div class="grid__item one-half cart_select">
                                                            <div class="ajaxcart__qty input-group-btn">
                                                                <button type="button" class="ajaxcart__qty-adjust ajaxcart__qty--minus items-count" 
                                                                 onclick="updateProductQuantity(${item.productId}, -1)" value="-">-</button>
                                                                <input type="text" name="update[]" class="ajaxcart__qty-num number-sidebar" id="productQuantity_${item.productId }" value="${item.quantity}"
                                                                data-line="1" aria-label="quantity" maxlength="3">
                                                                <button type="button" class="ajaxcart__qty-adjust ajaxcart__qty--minus items-count" 
                                                                onclick="updateProductQuantity(${item.productId}, 1)" value="+">+</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="grid">
                                                        <div class="grid__item one-half text-right cart_prices">
                                                            <span class="cart-price">
                                                            	<fmt:formatNumber value="${item.price * item.quantity }" minFractionDigits="0"></fmt:formatNumber>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    </c:forEach>
                                    <div class="ajaxcart__footer ajaxcart__footer--fixed cart-footer">
                                        <div class="row">
                                            <div class="col-lg-4 col-12 offset-lg-8 offset-xl-8">
                                                <div class="ajaxcart__subtotal">
                                                    <div class="cart__subtotal">
                                                        <div class="cart__col-6">
                                                            Tổng tiền:
                                                        </div>
                                                        <div class="text-right cart__totle">
                                                            <span class="total-price"> <fmt:formatNumber value="${totalCartPrice }" minFractionDigits="0"></fmt:formatNumber> <sup>vnd</sup> </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <div class="page-breadcrumb">
                                    <div class="row">
                                        <div class="main__products-title">
                                            <p>Thông tin khách hàng</p>
                                        </div>
                                    </div>
                                    <form action="${classpath }/cart-view" method="get">
                                        <div class="col-12">
                                            <div class="card">
                                                <div class="card-body">
                                                    <div class="form-body">
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="form-group mb-4">
                                                                    <label for="name">Tên</label>
                                                                    <input type="text" class="form-control" id="txtName" name="txtName" placeholder="your name" value="${loginedUser.name }">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="form-group mb-4">
                                                                    <label for="mobile">Số điện thoại</label>
                                                                    <input type="text" class="form-control" id="txtMobile" name="txtMobile" placeholder="your phone number" value="${loginedUser.mobile }">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="form-group mb-4">
                                                                    <label for="phone">Email</label>
                                                                    <input type="email" class="form-control" id="txtEmail" name="txtEmail" placeholder="your email" value="${loginedUser.email }">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="form-group mb-4">
                                                                    <label for="phone">Địa chỉ</label>
                                                                    <input type="text" class="form-control" id="txtAddress" name="txtAddress" placeholder="your address" value="${loginedUser.address }">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="form-group mb-4">
                                                                    <a href="${classpath }/allproduct" class="btn btn-primary active" role="button" aria-pressed="true">Mua thêm</a>
                                                                    <button class="btn btn-primary" onclick="_placeOrder(event)">Đặt hàng</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    </c:when>
                    <c:otherwise>
							<div class="row">
								<div class="col-12">
									<c:choose>
										<c:when test="${checkout }">
											<h3 align="center"
												class="page-title text-truncate text-dark font-weight-medium mb-1">
												<span id="placeOrderSuccess">Bạn đã đặt hàng thành công</span>
											</h3>
										</c:when>
										<c:otherwise>
											<h3 align="center"
												class="page-title text-truncate text-dark font-weight-medium mb-1">
												<span>Your cart: ${errorMessage }</span>
											</h3>
										</c:otherwise>
									</c:choose>

								</div>
							</div>
							<div class="row">
								<div class="col-md-12" align="center">
									<div class="form-group mb-4">
										<a href="${classpath }/allproduct" class="btn btn-primary active"
											role="button" aria-pressed="true"> Mua thêm </a>
									</div>
								</div>
							</div>

						</c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </main>
    <jsp:include page="/WEB-INF/views/frontend/layout/footer.jsp"></jsp:include>
    <jsp:include page="/WEB-INF/views/frontend/layout/js.jsp"></jsp:include>
    <script type="text/javascript">
    	updateProductQuantity = function(_productId, _quantity){
    		let data = {
    			productId : _productId,// Lấy theo id
    			quantity: _quantity,
    		};
    		
    		// $ === jQuery
    		jQuery.ajax({
    			url : "/update-product-quantity",
    			type: "POST",
    			contentType : "application/json",
    			data : JSON.stringify(data),
    			dataType : "json",// Kiểu dữ liệu trả về từ controller là json
    			
    			success: function(jsonResult){
    				let totalProducts = jsonResult.totalCartProducts;
    				// Viết lại số lượng sau khi bấm nút -, +
    				$("#productQuantity_" + jsonResult.productId).html(jsonResult.newQuantity);
    				location.reload();// Load lại trang
    			},
    			
    			error : function(jqXhr, testStatus, errorMessage){
    				alert("An error occur");
    			}
    			
    		});
    	}
    </script>
    <script type="text/javascript">
		function _placeOrder(event){
			 event.preventDefault();
			// javascript object
			let data = {
				txtName : jQuery("#txtName").val(),
				txtEmail : jQuery("#txtEmail").val(), // Get by Id
				txtMobile : jQuery("#txtMobile").val(),
				txtAddress : jQuery("#txtAddress").val(),
			};
			// $ === jQuery
			jQuery.ajax({
				url : "/place-order",
				type : "POST",
				contentType: "application/json",
				data : JSON.stringify(data),
				dataType: "json",// Kiểu dữ liệu trả về từ controller là json
				
				success: function(jsonResult){
					alert(jsonResult.code + ": " + jsonResult.message);
				},
				
				error : function(jqXhr, textStatus, errorMessage){
					alert("An error occur" + errorMessage);
				}
			});
		}
    </script>
    
</body>
</html>