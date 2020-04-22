
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>


<!DOCTYPE html>
<html lang="en">
<head>
    <%@ page isELIgnored="false" %>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Book Library</title>
</head>
<body>
    <div>
        <h2>New Book</h2>
        <div>
            <div>
                <form:form action="${contextPath}/add" modelAttribute="book" method="post">
                    <div>
                        <div>
                            <form:label path="author">Author</form:label>
                            <form:input type="text" id="author" path="author"/>
                            <form:errors path="author" />
                        </div>
                        <div>
                            <form:label path="name">Name</form:label>
                            <form:input type="text" id="name" path="name"/>
                            <form:errors path="name" />
                        </div>
                    </div>
                    <div>
                        <div>
                            <input type="submit" value="Add Book">
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
    </body>
</html>