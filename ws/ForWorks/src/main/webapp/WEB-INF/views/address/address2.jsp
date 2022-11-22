<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ForWorks</title>

    <link rel="stylesheet" href="${root}/resources/css/address/email.css" />
    <link rel="stylesheet" href="${root}/resources/css/address/style.css" />
    <script src="https://kit.fontawesome.com/3a92c85ff9.js" crossorigin="anonymous"></script>
    <style>
      .star {
        visibility: hidden;
        cursor: pointer;
      }
      .star:before {
        content: "\f005";
        font-family: FontAwesome;
        color: #ccc;
        position: absolute;
        visibility: visible;
      }
      .star:checked:before {
        content: "\f005";
        color: #ffc107;
        font-family: FontAwesome;
        position: absolute;
      }
    </style>
  </head>

  <body>
    <div id="app">
      <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

      <div id="main">
        <%@ include file="/WEB-INF/views/common/header.jsp" %>

        <div class="page-heading email-application">
          <div class="page-title">
            <div class="row">
              <div class="col-12 col-md-6 order-md-1 order-last mb-2">
                <h3>주소록</h3>
                <p class="text-subtitle text-muted">An application for user to check inbox</p>
              </div>
            </div>
          </div>
          <section class="section content-area-wrapper">
            <div class="sidebar-left">
              <div class="sidebar" style="height: 100%">
                <div class="sidebar-content email-app-sidebar d-flex" style="width: 150px; height: 100%">
                  <div class="email-app-menu">
                    <div class="sidebar-menu-list ps">
                      <!-- sidebar label start -->
                      <label class="sidebar-label mb-4">Menu</label>
                      <div class="list-group list-group-labels">
                        <a href="#" class="list-group-item active d-flex">
                          <svg class="" width="1.5em" height="1.5em" fill="currentColor">
                            <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#building" />
                          </svg>
                          <h6 style="padding-left: 10px; padding-top: 5px">조직</h6>
                        </a>
                        <a href="#" class="list-group-item d-flex">
                          <svg class="" width="1.5em" height="1.5em" fill="currentColor">
                            <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#star" />
                          </svg>
                          <h6 style="padding-left: 10px; padding-top: 5px">중요</h6>
                        </a>
                        <a href="#" class="list-group-item d-flex">
                          <svg class="" width="1.5em" height="1.5em" fill="currentColor">
                            <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#archive" />
                          </svg>
                          <h6 style="padding-left: 10px; padding-top: 5px">부서</h6>
                        </a>
                        <a href="#" class="list-group-item d-flex">
                          <svg class="" width="1.5em" height="1.5em" fill="currentColor">
                            <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#app-indicator" />
                          </svg>
                          <h6 style="padding-left: 10px; padding-top: 5px">외부</h6>
                        </a>
                      </div>
                      <!-- sidebar label end -->
                      <div class="ps__rail-x" style="left: 0px; bottom: 0px">
                        <div class="ps__thumb-x" tabindex="0" style="left: 0px; width: 0px"></div>
                      </div>
                      <div class="ps__rail-y" style="top: 0px; right: 0px">
                        <div class="ps__thumb-y" tabindex="0" style="top: 0px; height: 0px"></div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="content-right" style="width: 100%">
              <div class="email-app-area">
                <!-- Email list Area -->
                <div class="email-app-list-wrapper">
                  <div class="email-app-list">
                    <div class="email-action">
                      <!-- action left start here -->
                      <div class="action-left d-flex align-items-center">
                        <!-- 상태 -->
                        <div class="input-group">
                          <label class="input-group-text" for="inputGroupSelect01">내 상태</label>
                          <select class="form-select" id="inputGroupSelect01">
                            <option selected>알수없음</option>
                            <option value="1">자리</option>
                            <option value="2">자리비움</option>
                            <option value="3">외출</option>
                            <option value="3">응답불가</option>
                          </select>
                        </div>
                      </div>
                      <!-- action left end here -->
                      <!-- action right start here -->
                      <div class="action-right d-flex flex-grow-1 align-items-center justify-content-around">
                        <!-- search bar  -->
                        <div class="email-fixed-search flex-grow-1">
                          <div class="form-group position-relative mb-0 has-icon-left">
                            <input type="text" class="form-control" placeholder="검색 .." />
                            <div class="form-control-icon">
                              <svg class="bi" width="1.5em" height="1.5em" fill="currentColor">
                                <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#search" />
                              </svg>
                            </div>
                          </div>
                        </div>

                        <!-- pagination and page count -->
                        <span class="d-none d-sm-block">1-15 of 653</span>
                        <button class="btn btn-icon email-pagination-prev d-none d-sm-block">&lt;</button>
                        <button class="btn btn-icon email-pagination-next d-none d-sm-block">&gt;</button>
                      </div>
                    </div>
                    <!-- / action right -->
                    <div class="card">
                      <div class="card-body pt-2">
                        <table class="table" id="table1">
                          <thead>
                            <tr>
                              <th></th>
                              <th></th>
                              <th>이름</th>
                              <th>직급</th>
                              <th>부서</th>
                              <th>전화번호</th>
                              <th>이메일</th>
                              <th>내선번호</th>
                            </tr>
                          </thead>
                          <tbody>
                            <tr>
                              <td>
                                <input type="checkbox" class="star" checked />
                              </td>
                              <td>
                                <div class="avatar">
                                  <img src="${root}/resources/img/member-imgs/user.png" alt="img" />
                                  <span class="avatar-status bg-success"></span>
                                </div>
                              </td>
                              <td>Graiden</td>
                              <td>Offenburg</td>
                              <td>Offenburg</td>
                              <td>076 4820 8838</td>
                              <td>vehicula.aliquet@semco.co.uk</td>
                              <td>
                                <span class="badge bg-success">Active</span>
                              </td>
                            </tr>
                            <tr>
                              <td>
                                <input type="checkbox" class="star" />
                              </td>
                              <td>
                                <div class="avatar">
                                  <img src="${root}/resources/img/member-imgs/user.png" alt="img" />
                                  <span class="avatar-status bg-warning"></span>
                                </div>
                              </td>
                              <td>Graiden</td>
                              <td>New Quay</td>
                              <td>New Quay</td>
                              <td>0500 527693</td>
                              <td>fringilla.euismod.enim@quam.ca</td>
                              <td>
                                <span class="badge bg-success">Active</span>
                              </td>
                            </tr>
                            <tr>
                              <td>
                                <input type="checkbox" class="star" />
                              </td>
                              <td>
                                <div class="avatar">
                                  <img src="${root}/resources/img/member-imgs/user.png" alt="img" />
                                  <span class="avatar-status bg-secondary"></span>
                                </div>
                              </td>
                              <td>Graiden</td>
                              <td>GrumoAppula</td>
                              <td>GrumoAppula</td>
                              <td>(012165) 76278</td>
                              <td>mi.Duis@diam.edu</td>
                              <td>
                                <span class="badge bg-danger">Inactive</span>
                              </td>
                            </tr>
                            <tr>
                              <td>
                                <input type="checkbox" class="star" />
                              </td>
                              <td>
                                <div class="avatar">
                                  <img src="${root}/resources/img/member-imgs/user.png" alt="img" />
                                  <span class="avatar-status bg-warning"></span>
                                </div>
                              </td>
                              <td>Graiden</td>
                              <td>Ways</td>
                              <td>Ways</td>
                              <td>0309 690 7871</td>
                              <td>velit@nec.com</td>
                              <td>
                                <span class="badge bg-success">Active</span>
                              </td>
                            </tr>
                            <tr>
                              <td>
                                <input type="checkbox" class="star" />
                              </td>
                              <td>
                                <div class="avatar">
                                  <img src="${root}/resources/img/member-imgs/user.png" alt="img" />
                                  <span class="avatar-status bg-success"></span>
                                </div>
                              </td>
                              <td>Graiden</td>
                              <td>Rossignol</td>
                              <td>Rossignol</td>
                              <td>0500 441046</td>
                              <td>rhoncus.id@Aliquamau.net</td>
                              <td>
                                <span class="badge bg-success">Active</span>
                              </td>
                            </tr>
                            <tr>
                              <td>
                                <input type="checkbox" class="star" />
                              </td>
                              <td>
                                <div class="avatar">
                                  <img src="${root}/resources/img/member-imgs/user.png" alt="img" />
                                  <span class="avatar-status bg-success"></span>
                                </div>
                              </td>
                              <td>Kermit</td>
                              <td>Patna</td>
                              <td>Patna</td>
                              <td>(01653) 27844</td>
                              <td>diam.Sed.diam@anteViv.org</td>
                              <td>
                                <span class="badge bg-success">Active</span>
                              </td>
                            </tr>
                            <tr>
                              <td>
                                <input type="checkbox" class="star" />
                              </td>
                              <td>
                                <div class="avatar">
                                  <img src="${root}/resources/img/member-imgs/user.png" alt="img" />
                                  <span class="avatar-status bg-success"></span>
                                </div>
                              </td>
                              <td>Jermaine</td>
                              <td>Mold</td>
                              <td>Mold</td>
                              <td>0800 528324</td>
                              <td>sodales@nuncsit.org</td>
                              <td>
                                <span class="badge bg-success">Active</span>
                              </td>
                            </tr>
                            <tr>
                              <td>
                                <input type="checkbox" class="star" />
                              </td>
                              <td>
                                <div class="avatar">
                                  <img src="${root}/resources/img/member-imgs/user.png" alt="img" />
                                  <span class="avatar-status bg-success"></span>
                                </div>
                              </td>
                              <td>Ferdinand</td>
                              <td>Marlborough</td>
                              <td>Marlborough</td>
                              <td>(016977) 4107</td>
                              <td>gravida.molestie@tincidunt.org</td>
                              <td>
                                <span class="badge bg-danger">Inactive</span>
                              </td>
                            </tr>
                            <tr>
                              <td>
                                <input type="checkbox" class="star" />
                              </td>
                              <td>
                                <div class="avatar">
                                  <img src="${root}/resources/img/member-imgs/user.png" alt="img" />
                                  <span class="avatar-status bg-success"></span>
                                </div>
                              </td>
                              <td>Kuame</td>
                              <td>Tresigallo</td>
                              <td>Tresigallo</td>
                              <td>(0151) 561 8896</td>
                              <td>Quisque.purus@mauris.org</td>
                              <td>
                                <span class="badge bg-success">Active</span>
                              </td>
                            </tr>
                            <tr>
                              <td>
                                <input type="checkbox" class="star" />
                              </td>
                              <td>
                                <div class="avatar">
                                  <img src="${root}/resources/img/member-imgs/user.png" alt="img" />
                                  <span class="avatar-status bg-success"></span>
                                </div>
                              </td>
                              <td>Deacon</td>
                              <td>Karapınar</td>
                              <td>Karapınar</td>
                              <td>07740 599321</td>
                              <td>Duis.a.mi@sociisnatoque.com</td>
                              <td>
                                <span class="badge bg-success">Active</span>
                              </td>
                            </tr>
                            <tr>
                              <td>
                                <input type="checkbox" class="star" />
                              </td>
                              <td>
                                <div class="avatar">
                                  <img src="${root}/resources/img/member-imgs/user.png" alt="img" />
                                  <span class="avatar-status bg-success"></span>
                                </div>
                              </td>
                              <td>Channing</td>
                              <td>Warrnambool</td>
                              <td>Warrnambool</td>
                              <td>0845 46 49</td>
                              <td>tempor.bibendum.Donec@ornarel.ca</td>
                              <td>
                                <span class="badge bg-success">Active</span>
                              </td>
                            </tr>
                            <tr>
                              <td>
                                <input type="checkbox" class="star" />
                              </td>
                              <td>
                                <div class="avatar">
                                  <img src="${root}/resources/img/member-imgs/user.png" alt="img" />
                                  <span class="avatar-status bg-success"></span>
                                </div>
                              </td>
                              <td>Aladdin</td>
                              <td>Bothey</td>
                              <td>Bothey</td>
                              <td>0800 1111</td>
                              <td>sem.ut@pellentesquea.ca</td>
                              <td>
                                <span class="badge bg-success">Active</span>
                              </td>
                            </tr>
                            <tr>
                              <td>
                                <input type="checkbox" class="star" />
                              </td>
                              <td>
                                <div class="avatar">
                                  <img src="${root}/resources/img/member-imgs/user.png" alt="img" />
                                  <span class="avatar-status bg-success"></span>
                                </div>
                              </td>
                              <td>Cruz</td>
                              <td>Shikarpur</td>
                              <td>Shikarpur</td>
                              <td>07624 944915</td>
                              <td>non@quisturpisvitae.ca</td>
                              <td>
                                <span class="badge bg-success">Active</span>
                              </td>
                            </tr>
                            <tr>
                              <td>
                                <input type="checkbox" class="star" />
                              </td>
                              <td>
                                <div class="avatar">
                                  <img src="${root}/resources/img/member-imgs/user.png" alt="img" />
                                  <span class="avatar-status bg-success"></span>
                                </div>
                              </td>
                              <td>Keegan</td>
                              <td>Assen</td>
                              <td>Assen</td>
                              <td>0800 200103</td>
                              <td>molestie.dapibus@condimentum.edu</td>
                              <td>
                                <span class="badge bg-success">Active</span>
                              </td>
                            </tr>
                            <tr>
                              <td>
                                <input type="checkbox" class="star" />
                              </td>
                              <td>
                                <div class="avatar">
                                  <img src="${root}/resources/img/member-imgs/user.png" alt="img" />
                                  <span class="avatar-status bg-success"></span>
                                </div>
                              </td>
                              <td>Keegan</td>
                              <td>Assen</td>
                              <td>Assen</td>
                              <td>0800 200103</td>
                              <td>molestie.dapibus@condimentum.edu</td>
                              <td>
                                <span class="badge bg-success">Active</span>
                              </td>
                            </tr>
                          </tbody>
                        </table>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </section>
        </div>
      </div>
    </div>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
  </body>
</html>
