<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>


<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>


<!DOCTYPE html>
<html>
<head>
    <%@ page isELIgnored="false" %>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Book Library</title>
</head>
<body>
    <div>
        <div>
            <h2>Library</h2>
            <hr/>
            <a href="${contextPath}/new-book">
                <button type="submit">Add new book</button>
            </a>
            <a href="${contextPath}/nextpage">
                <button type="submit">Next Page</button>
            </a>
            
            <form action="${contextPath}/nextpage" method = "get">
            	<input type="submit" value="Another way to go to the Next Page" />
            </form>
            <br/><br/>
            <div>
                <div>
                    <div>Books List</div>
                </div>
                <div>
                    <table>
                        <tr>
                            <th>Id</th>
                            <th>Author</th>
                            <th>Name</th>
                        </tr>
                        <c:forEach var="book" items="${books}">
                            <tr>
                                <td>${book.id}</td>
                                <td>${book.author}</td>
                                <td>${book.name}</td>
                                <td>
                                    <a href="${contextPath}/${book.id}">Edit</a>
                                    <form action="${contextPath}/${book.id}/delete" method="post">
                                        <input type="submit" value="Delete" />
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>