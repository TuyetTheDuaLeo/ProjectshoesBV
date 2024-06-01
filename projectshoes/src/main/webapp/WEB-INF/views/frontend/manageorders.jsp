<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!-- directive của JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${title }</title>
<link rel="icon" type="image/x-icon"
	href="${classpath }/frontend/img/favicon.webp">
<!-- Css -->
<jsp:include page="/WEB-INF/views/frontend/layout/css.jsp"></jsp:include>
</head>

<body>
	<!-- Header -->
	<jsp:include page="/WEB-INF/views/frontend/layout/header.jsp"></jsp:include>
	<main class="bg-light">
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
			<div id="myorder">
				<div class="container">
					<div class="product-title">
						<p>Đơn hàng của bạn</p>
					</div>
					<div class="row">
						<div class="col-12">
							<form action="get">
								<input type="hidden" id="currentPage" name="currentPage"
									class="form-control" value="${orrderSearch.currentPage }">
								<div class="table-responsive">
									<!-- Bổ sung lớp table-responsive -->
									<table class="table">
										<thead>
											<tr>
												<th scope="col" class="text-center">STT</th>
												<th scope="col" class="text-center">NGÀY ĐẶT</th>
												<th scope="col" class="text-center">THÀNH TIỀN</th>
												<th scope="col" class="text-center">ĐỊA CHỈ</th>
												<th scope="col" class="text-center">SỐ ĐIỆN THOẠI</th>
												<th scope="col" class="text-center">TRẠNG THÁI</th>
												<th scope="col" class="text-center">HÀNH ĐỘNG</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="saleOrder" items="${saleOrders }"
												varStatus="loop">
												<tr>
													<th scope="row">${loop.index + 1 }</th>
													<td><fmt:formatDate pattern="dd-MM-yyyy"
															value="${saleOrder.createDate}" /></td>
													<td>$ <fmt:formatNumber value="${saleOrder.total }"
															pattern="#,##0₫" />
													</td>
													<td>${saleOrder.customerAddress }</td>
													<td>${saleOrder.customerMobile }</td>
													<td><c:choose>
															<c:when test="${saleOrder.status}">
																	        Đã giao hàng
																	    </c:when>
															<c:otherwise>
																	Chư giao hàng
															</c:otherwise>
														</c:choose></td>
													<td>
														<!-- Button trigger modal --> <a type="button"
														class="btn-details" data-toggle="modal"
														data-target="#exampleModalCenter${loop.index}"> <i
															class="fa-solid fa-eye"></i>
													</a> <!-- Modal -->
														<div class="modal fade"
															id="exampleModalCenter${loop.index}" tabindex="-1"
															role="dialog" aria-labelledby="exampleModalCenterTitle"
															aria-hidden="true">
															<div
																class="modal-dialog modal-dialog-centered modal-order"
																role="document">
																<div class="modal-content">
																	<div class="modal-header">
																		<h5 class="modal-title" id="exampleModalLongTitle">Chi
																			tiết đặt hàng</h5>
																		<h5 class="modal-title" id="exampleModalLongTitle">
																			Tổng thành tiền:
																			<fmt:formatNumber value="${saleOrder.total }"
																				pattern="#,##0₫" />
																		</h5>
																	</div>
																	<div class="modal-body">
																		<div class="product-detail table-responsive">
																			<table class="table">
																				<thead>
																					<tr>
																						<th scope="col" class="text-center">STT</th>
																						<th scope="col" class="text-center">Ảnh sản
																							phẩm</th>
																						<th scope="col" class="text-center">Tên sản
																							phẩm</th>
																						<th scope="col" class="text-center">Size</th>
																						<th scope="col" class="text-center">Số lượng</th>
																						<th scope="col" class="text-center">Giá</th>
																					</tr>
																				</thead>
																				<tbody>
																					<c:forEach var="item"
																						items="${orderProductMap[saleOrder.id]}"
																						varStatus="innerLoop">
																						<tr>
																							<th scope="row">${innerLoop.index + 1 }</th>
																							<td><img
																								src="${classpath}/FileUploads/${item.product.avatar }">
																							</td>

																							<td>${item.product.name }</td>
																							<td>${item.size }</td>
																							<td>${item.quantity }</td>
																							<td><c:choose>
																									<c:when
																										test="${not empty item.product.salePrice}">
																										<fmt:formatNumber
																											value="${item.product.salePrice}"
																											pattern="#,##0₫" />
																									</c:when>
																									<c:otherwise>
																										<fmt:formatNumber
																											value="${item.product.price}"
																											pattern="#,##0₫" />
																									</c:otherwise>
																								</c:choose></td>

																						</tr>
																					</c:forEach>
																				</tbody>
																			</table>
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
								<div class="mt-3">
									<div class="pagination justify-content-center">
										<div id="paging"></div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<!-- Footer -->
	<jsp:include page="/WEB-INF/views/frontend/layout/footer.jsp"></jsp:include>
	<!-- Js -->
	<jsp:include page="/WEB-INF/views/frontend/layout/js.jsp"></jsp:include>
	<!-- pagination -->
	<script type="text/javascript">
		$( document ).ready(function() {	
			$("#paging").pagination({
				currentPage: ${orrderSearch.currentPage}, //Trang hien tai
				items: ${orrderSearch.totalItems}, //Tong so san pham (total products)
				itemsOnPage: ${orrderSearch.sizeOfPage},
				cssStyle: 'light-theme',
				onPageClick: function(pageNumber, event) {
					event.preventDefault();
					$('#currentPage').val(pageNumber);
				     // Sử dụng URL phân trang được truyền từ controller
	                window.location.href = "${paginationUrl}" + pageNumber;
				},
			});
		});
	</script>
</body>
</html>