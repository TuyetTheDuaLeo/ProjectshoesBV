<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<nav id="sidebar" class="sidebar js-sidebar">
			<div class="sidebar-content js-simplebar">
				<a class="sidebar-brand" href="index.html">
          <span class="align-middle">Admin</span>
        </a>

				<ul class="sidebar-nav">
					<li class="sidebar-item active">
						<a class="sidebar-link" href="${classpath}/admin/home">
              			<i class="align-middle" data-feather="home"></i> 
			  			<span class="align-middle">Thống kê</span>
            			</a>
					</li>
					<li class="sidebar-header">
						SYSTEM ADMINISTRATION
					</li>
					<li class="sidebar-item">
						<a class="sidebar-link" href="${classpath}/admin/category/list">
              			<i class="align-middle" data-feather="tag"></i> 
			  			<span class="align-middle">Quản lý loại sản phẩm</span>
            			</a>
					</li>
					<li class="sidebar-item">
						<a class="sidebar-link" href="${classpath}/admin/product/list">
              			<i class="align-middle" data-feather="shopping-cart"></i> 
			  			<span class="align-middle">Quản lý sản phẩm</span>
            			</a>
					</li>
					<li class="sidebar-item">
						<a class="sidebar-link" href="${classpath}/admin/user/list">
              			<i class="align-middle" data-feather="user"></i> 
			  			<span class="align-middle">Quản lý tài khoản</span>
            			</a>
					</li>
					<li class="sidebar-item">
						<a class="sidebar-link" href="${classpath }/admin/role/list">
              			<i class="align-middle" data-feather="clipboard"></i> 
			  			<span class="align-middle">Quản lý quyền</span>
            			</a>
					</li>
					<li class="sidebar-item">
						<a class="sidebar-link" href="${classpath }/admin/order/list">
              			<i class="align-middle" data-feather="calendar"></i> 
			  			<span class="align-middle">Quản lý đơn hàng</span>
            			</a>
					</li>
					<li class="sidebar-item">
						<a class="sidebar-link" href="pages-profile.html">
              			<i class="align-middle" data-feather="mail"></i> 
			  			<span class="align-middle">Liên hệ</span>
            			</a>
					</li>
					<li class="sidebar-header">
						AUTHENTICATION
					</li>
					<li class="sidebar-item">
						<a class="sidebar-link" href="${classpath }/signup">
              				<i class="align-middle" data-feather="lock"></i> 
			  				<span class="align-middle">Đăng ký</span>
            			</a>
					</li>
					<li class="sidebar-item">
						<a class="sidebar-link" href="${classpath }/login">
            		  	<i class="align-middle" data-feather="log-in"></i>
					   	<span class="align-middle">Đăng nhập</span>
            			</a>
					</li>
					<li class="sidebar-item">
						<a class="sidebar-link" href="${classpath }/login">
              				<i class="align-middle" data-feather="log-out"></i> 
			  				<span class="align-middle">Đăng xuất</span>
            			</a>
					</li>
				</ul>
			</div>
		</nav>
		