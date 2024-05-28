SELECT c.clientNo, fName, lName, propertyNo, commentclientNo
FROM Client c, Viewing v
WHERE c.clientNo = v.clientNo;

