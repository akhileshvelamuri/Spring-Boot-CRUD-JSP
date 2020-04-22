
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
        <h2>New User</h2>
        <div>
            <div>
                <form action="${contextPath}/${book.id}/update" method="post">
                    <div>
                        <div>
                            Id: ${book.id}
                        </div>
                        <div>
                            <label>Author</label>
                            <input type="text" id="author" name="author" value = "${book.author}"/>
                        </div>
                        <div>
                            <label>Name</label>
                            <input type="text" id="name" name="name" value = "${book.name}"/>
                        </div>
                    </div>
                    <div>
                        <div>
                            <input type="submit" value="Update Book">
                        </div>
                    </div>
                 </form>
            </div>
        </div>
    </div>
    </body>
</html>