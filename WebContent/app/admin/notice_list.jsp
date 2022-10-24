<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
   		<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/font.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/contents.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/notice.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/form.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/page.css"/>

    <!-- 버튼 클릭 시 확인 알림창 -->
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/assets/js/admin/check.js"></script>
    <title>관리자-공지 관리</title>
</head>

<body>

    <div id="wrapper">
        <!-- 세로 메뉴바 -->
		<jsp:include page="${pageContext.request.contextPath}/app/admin/admin_menu.jsp"/>

        <!-- 헤더 ~ 밑에 메인 컨텐츠 -->
        <div id="container">
            <!-- 헤더 -->
            <header>
                <span id="admin-header-title" class="short">공지 관리</span>
                <span id="admin-mode">관리자 모드</span>
                <span id="userCount">가입된 회원 수 총 <strong> <c:out value="${userTotalCount}"/> </strong>명</span>
            </header>

            <!-- 컨텐츠 검색 부분 -->
            <div class="p-contents chart-no">

                <!-- 검색어 입력 폼 -->
                <form action="" name="searchForm" method="post">
                    <div class="search-form">
                        <span class="s-form">
                            <select name="searchSelect" class="s-select">
                                <option value="title">제목</option>
                                <option value="content">내용</option>
                                <option value="all">제목 + 내용</option>
                            </select>
                        </span>
                        <span class="s-f-input">
                            <span class="search-input">
                                <input type="text" name="programSearch" placeholder="검색어를 입력하세요">
                            </span>
                        </span>
                        <button type="button" class="">
                            <img src="${pageContext.request.contextPath}/assets/images/common/search.png">
                        </button>
                    </div>
                </form>

            </div>

            <!-- 프로그램 리스트 출력 틀 -->
            <div class="p-contents contents-bottom">
                <span class="list-count">총
                    <span><c:out value="${total}"/></span>건
                </span>

                <table>
                    <tr class="title">
                        <th class="num">공지번호</th>
                        <th class="title">제목</th>
                        <th class="content">내용</th>
                        <th class="file-check">첨부파일</th>
                        <th class="date">작성날짜</th>
                        <th class="hits">조회수</th>
                        <th class="revise"></th>
                        <th class="delete"></th>
                    </tr>
                    <!-- ↓ 데이터 출력 -->
                    <tbody class="tbody">
                    <c:choose>
                    	<c:when test="${userList != null and fn:length(userList) > 0}">
                    		<c:forEach var="noticeList" items="${userList}">
                   				 <tr>
	                    			<td><c:out value="${noticeList.getNoticeNumber()}"/></td>
	                    			<td><c:out value="${noticeList.getNoticeTitle()}"/></td>
	                    			<td><c:out value="${noticeList.getNoticeContent()}"/></td>
	                    			<td><img src="${pageContext.request.contextPath}/assets/images/common/fileImage.png"></td>
	                    			<td><c:out value="${noticeList.getNoticeDate()}"/></td>
	                    			<td><c:out value="${noticeList.getNoticeViewCount()}"/></td>
	                    			<td class="revise"><input type="button" value="수정"></td>
	                    			<td class="delete"><input type="button" value="삭제" onclick="deleteCheck(this); location.href = '${pageContext.request.contextPath}/admin/NoticeListDeleteOk.ad?noticeNumber=${noticeList.getNoticeNumber()}';"></td>
                    			</tr>
                    		</c:forEach>
                    	</c:when>
                   </c:choose>
                 <%--    <tr>
                        <td>12432</td>
                        <td class="title" onclick="location.href='#'">첫 번째 공지</td>
                        <td class="content">첫 번째 공지입니다.</td>
                        <td><img src="${pageContext.request.contextPath}/assets/images/common/fileImage.png"></td>
                        <td>2022-10-03 10:00</td>
                        <td>86</td>
                        <td class="revise"><input type="button" value="수정"></td>
                        <td class="delete"><input type="button" value="삭제" onclick="deleteListCheck()"></td>
                    </tr> --%>
                   
                </table>

                <!-- 페이징 -->
                <div id="page">
                    <div class="page_nation">
                    		<c:if test="${prev}">
		                        <a class="page-num arrow pprev" href="${pageContext.request.contextPath}/admin/NoticeListOk.ad?page=1"></a>
		                        <a class="page-num arrow prev" href="${pageContext.request.contextPath}/admin/NoticeListOk.ad?page=${startPage -1}"></a>
		                    </c:if>
                        <c:forEach var="i" begin="${startPage}" end="${endPage}" >
                         <c:choose>
                        	<c:when test="${not (i eq page)}">
		                        <a href="${pageContext.request.contextPath}/admin/NoticeListOk.ad?page=${i}" class="page-num">
		                        <c:out value="${i}"/>
		                        </a>
                        	</c:when>
                        	<c:otherwise> 
                        		<a href="${pageContext.request.contextPath}/admin/NoticeListOk.ad?page=${i}" class="active">
		                       	 <c:out value="${i}"/>
		                        </a>
                        	</c:otherwise>
                        	</c:choose>
                        </c:forEach>
		                	   <c:if test="${next}">
		                        <a class="page-num arrow next" href="${pageContext.request.contextPath}/admin/NoticeListOk.ad?page=${endPage +1}"></a>
		                        <a class="page-num arrow nnext" href="${pageContext.request.contextPath}/admin/NoticeListOk.ad?page=${realEndPage}"></a>
		                        </c:if>
                    </div>
                </div>
                <div id="write">
                    <input type="button" onclick="location.href='${pageContext.request.contextPath}/admin/NoticeWrite.ad'" value="작성">
                </div>

            </div>

        </div>

    </div>

</body>
<script src="${pageContext.request.contextPath}/assets/js/admin/adminNotice.js"></script>
</html>