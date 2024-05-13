<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${classpath}/frontend/css/contact.css">
    <jsp:include page="/WEB-INF/views/frontend/layout/css.jsp"></jsp:include>
    <title>${title}</title>
</head>
<body>
    <jsp:include page="/WEB-INF/views/frontend/layout/header.jsp"></jsp:include>
    <nav>
        <div class="bread-crumb">
            <div class="container">
                <div class="nd-main-title-breadcrumb text-center">
                    Liên hệ
                </div>
                <ul class="breadcrumb">
                    <li class="home" itemprop="itemListElement">
                        <a href="" itemprop="item" title="Trang chủ">
                            <span itemprop="name">Trang Chủ</span>
                        </a>
                    </li>
                    <li itemprop="itemListElement">
                        <strong itemprop="name">Liên hệ</strong>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <main>
        <div class="container contact page-contacts">
            <div class="row contact-padding">
                <div class="col-lg-6 col-sm-12 leave-your-message order-md-2">
                    <h3>Liên hệ chúng tôi</h3>
                    <p class="p-bottom">Để liên hệ và nhận các thông tin khuyến mãi sớm nhất, Chúng tôi sẽ liên lạc với bạn trong thời gian sớm nhất</p>
                    <form action="/contact-send" method="post" id="contact" accept-charset="UTF-8">
                        <div class="row">
                            <div class="col-sm-12 col-xs-12">
                                <fieldset class="form-group">
                                    <label for="">
                                        Họ tên
                                        <span class="required">*</span>
                                    </label>
                                    <input type="text" placeholder="Nhập họ tên" id="name" class="form-control  form-control-lg" name="txtName">
                                </fieldset>
                            </div>
                            <div class="col-sm-12 col-xs-12">
                                <fieldset class="form-group">
                                    <label for="">
                                        Email
                                        <span class="required">*</span>
                                    </label>
                                    <input type="mail" placeholder="Nhập địa chỉ email" id="mail" 
                                    class="form-control  form-control-lg" name="txtEmail">
                                </fieldset>
                            </div>
                            <div class="col-sm-12 col-xs-12">
                                <fieldset class="form-group">
                                    <label for="">
                                        Điện thoại
                                        <span class="required">*</span>
                                    </label>
                                    <input type="tel" placeholder="Nhập số điện thoại" id="tel" 
                                    class="form-control  form-control-lg" name="txtPhone">
                                </fieldset>
                            </div>
                            <div class="col-sm-12 col-xs-12">
                                <fieldset class="form-group">
                                    <label for="">
                                        Nội dung
                                        <span class="reuired">*</span>
                                    </label>
                                    <textarea name="txtMessage" id="comment" rows="5" class="form-control form-control-lg" 
                                    placeholder="Nội dung liên hệ"></textarea>
                                </fieldset>
                                <fieldset class="form-group">
                                    <button type="submit" class="btn btn-blues btn-style btn-style-active">Gửi liên hệ ngay</button>
                                </fieldset>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-lg-6 col-12 order-md-1">
                    <div class="contact-maps">
                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3723.8347348034436!2d105.77081187441749!3d21.039297680612666!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x313454b5534fb3bf%3A0x70d71b071349fa94!2sDevPro%20Education!5e0!3m2!1svi!2s!4v1704787728216!5m2!1svi!2s" width="400" height="300" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <jsp:include page="/WEB-INF/views/frontend/layout/footer.jsp"></jsp:include>
    <jsp:include page="/WEB-INF/views/frontend/layout/js.jsp"></jsp:include>
</body>
</html>