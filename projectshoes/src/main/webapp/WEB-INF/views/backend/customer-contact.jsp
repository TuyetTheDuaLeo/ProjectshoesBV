<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- directive của JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description"
	content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
<meta name="author" content="AdminKit">
<meta name="keywords"
	content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">

<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="shortcut icon"
	href="${classpath }/backend/img/icons/icon-48x48.png" />

<link rel="canonical"
	href="https://demo-basic.adminkit.io/pages-blank.html" />

<title>${title }</title>
<!-- variables -->
<jsp:include page="/WEB-INF/views/common/variables.jsp"></jsp:include>
<!-- Custome css resource file -->
<jsp:include page="/WEB-INF/views/backend/layout/css.jsp"></jsp:include>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap"
	rel="stylesheet">


</head>

<body>
	<div class="wrapper">
		<!-- Sidebar -->
		<jsp:include page="/WEB-INF/views/backend/layout/header.jsp"></jsp:include>
		<div class="main">
			<jsp:include page="/WEB-INF/views/backend/layout/mainnav.jsp"></jsp:include>	

			<main class="content">
				<div class="container-fluid p-0">

					<h1 class="h1 mb-3" style="font-weight: 700;">Danh sách liên hệ</h1>

					<div class="container-fluid">
						<!-- ============================================================== -->
						<!-- Start Page Content -->
						<!-- ============================================================== -->
						<!-- basic table -->
						<form action="${classpath }/admin/customer-contact" method="get">

							<div class="row">
								<div class="col-12">
									<div class="card">
										<div class="card-body">
											<div class="table-responsive">
												<div class="row">
													<div class="col-md-12 mb-3">
														<div class="form-group">
															<h3>Total contacts: ${contactSearch.totalItems}</h3>
														</div>
													</div>
												</div>
												<!-- Tìm kiếm -->
												<div class="row">
													<div class="col-md-2">
														<div class="form-group mb-4">
															<select class="form-control" id="status" name="status">
																<option value="2">Tất cả</option>
																<option value="1">Hoạt động</option>
																<option value="0">Không hoạt động</option>
															</select>
														</div>
													</div>

													<div class="col-md-2">
														<input class="form-control" type="date" id="beginDate"
															name="beginDate" />
													</div>
													<div class="col-md-2">
														<input class="form-control" type="date" id="endDate"
															name="endDate" />
													</div>

													<div class="col-md-3">
														<input type="text" class="form-control" id="keyword"
															name="keyword" placeholder="Search keyword" />
													</div>

													<div class="col-md-1">
														<button type="submit" id="btnSearch" name="btnSearch"
															class="btn btn-primary">Tìm</button>
													</div>
													<div class="col-md-1">
														<input id="currentPage" name="currentPage"
															class="form-control"
															value="${contactSearch.currentPage }">
													</div>
												</div>
												<!-- Hết tìm kiếm -->

												<table id="zero_config"
													class="table table-striped table-bordered no-wrap">
													<thead>
														<tr align="center">
															<th scope="col">STT</th>
															<th scope="col">Tên</th>
															<th scope="col">Điện thoại</th>
															<th scope="col">Email</th>
															<th scope="col">Địa chỉ</th>
															<th scope="col">Nội dung</th>
															<th scope="col">Người tạo</th>
															<th scope="col">Người cập nhập</th>
															<th scope="col">Ngày tạo</th>
															<th scope="col">Ngày cập nhập</th>
															<th scope="col">Trạng thái</th>
															<th scope="col">Hoạt động</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach var="contact" items="${customerContacts }"
															varStatus="loop">
															<tr>
																<td align="center">${loop.index + 1 }</td>
																<td>${contact.name }</td>
																<td align="center">${contact.mobile }</td>
																<td>${contact.email }</td>
																<td>${contact.address }</td>
																<td>${contact.message }</td>
																<td>${contact.userCreateCustomerContact.username }</td>
																<td>${contact.userUpdateCustomerContact.username }</td>
																<td><fmt:formatDate pattern="dd-MM-yyyy"
																		value="${contact.createDate}" /></td>
																<td><fmt:formatDate pattern="dd-MM-yyyy"
																		value="${contact.updateDate}" /></td>
																<td><c:choose>
																		<c:when test="${contact.status }">Hoạt động</c:when>
																		<c:otherwise>Đã kiểm tra</c:otherwise>
																	</c:choose></td>
																<td>
																<a href="${classpath }/admin/customer-contact/detail/${contact.id }"
																	role="button" class="btn btn-success">Chi tiết</a> 
																	
																<a href="${classpath }/admin/customer-contact/delete/${contact.id }"
																	role="button" class="btn btn-secondary">Xóa</a>
																</td>
															</tr>
														</c:forEach>
													</tbody>
												</table>

												<div class="row">
													<div class="col-md-12">
														<!-- Phan trang -->
														<div class="pagination justify-content-center">
															<div id="paging"></div>
														</div>
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
			</main>
			<!-- Footer -->
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/backend/layout/js.jsp"></jsp:include>
	<!-- pagination -->
	<script type="text/javascript">
		$( document ).ready(function() {
			//Dat gia tri cua status ung voi dieu kien search truoc do
			$("#status").val(${contactSearch.status});
			//Dat gia tri cua order ung voi dieu kien search truoc do	
			//$("#keyword").val(${saleOrderSearch.keyword});
			
			
			$("#paging").pagination({
				currentPage: ${contactSearch.currentPage}, //Trang hien tai
				items: ${contactSearch.totalItems}, //Tong so san pham (total products)
				itemsOnPage: ${contactSearch.sizeOfPage},
				cssStyle: 'light-theme',
				onPageClick: function(pageNumber, event) {
					$('#currentPage').val(pageNumber);
					$('#btnSearch').trigger('click');
				},
			});
		});
	</script>
</body>
</html>


