use csdlhangkhong;

-- Câu 1: Cho biết các chuyến bay đi đà Lạt (DAD)
select *
from chuyenbay
where GaDen='DAD';

-- Câu 2: Cho biết các loại máy bay có tầm bay lớn hơn 10,000km.
select *
from maybay
where TamBay>10000;

-- Câu 3: Tìm các nhân viên có lương nhỏ hơn 10,000.
select *
from nhanvien
where Luong<10000;

-- Câu 4: Cho biết các chuyến bay có độ dài ñường bay nhỏ hơn 10.000km và lớn hơn 8.000km
select *
from chuyenbay
where DoDai>8000 and DoDai<10000;

select *
from chuyenbay
where DoDai between 8000 and 10000;

-- Câu 5: Cho biết các chuyến bay xuất phát từ Sài Gòn (SGN) ñi Ban Mê Thuộc (BMV).
select *
from chuyenbay
where GaDi='SGN' and GaDen='BMV';

-- Câu 6: Có bao nhiêu chuyến bay xuất phát từ Sài Gòn (SGN).
select count(1)
from chuyenbay
where GaDi='SGN';

-- Câu 7: Có bao nhiêu loại máy báy Boeing
select count(1)
from maybay
where Loai like 'Boeing%';

-- Câu 8: Cho biết tổng số lương phải trả cho các nhân viên.
select sum(Luong)
from nhanvien;

-- Câu 9: Cho biết mã số của các phi công lái máy báy Boeing.
select distinct nhanvien.MaNV
from nhanvien
join chungnhan
on nhanvien.MaNV = chungnhan.MaNV
join maybay
on chungnhan.MaMB = maybay.MaMB
and Loai like 'Boeing%';

-- Câu 10: Cho biết các nhân viên có thể lái máy bay có mã số 747
select distinct chungnhan.MaNV
from chungnhan
join maybay
on chungnhan.MaMB = maybay.MaMB
and chungnhan.MaMB=747;

-- Câu 11: Cho biết mã số của các loại máy bay mà nhân viên có họ Nguyễn có thể lái
select distinct c.MaMB
from nhanvien
join chungnhan c on nhanvien.MaNV = c.MaNV
where nhanvien.Ten like 'Nguyen%';

-- Câu 12: Cho biết mã số của các phi công vừa lái được Boeing vừa lái được Airbus.
-- Cách 1:
select *
from
(select distinct nhanvien.MaNV
 from nhanvien
join chungnhan
on nhanvien.MaNV = chungnhan.MaNV
join maybay
on chungnhan.MaMB = maybay.MaMB
and Loai like 'Boeing%') e join
(select distinct nhanvien.MaNV
from nhanvien
join chungnhan
on nhanvien.MaNV = chungnhan.MaNV
join maybay
on chungnhan.MaMB = maybay.MaMB
and Loai like 'Airbus%') ai on e.MaNV=ai.MaNV;

select distinct nhanvien.MaNV
from nhanvien
join chungnhan
on nhanvien.MaNV = chungnhan.MaNV
join maybay
on chungnhan.MaMB = maybay.MaMB
and Loai like 'Boeing%';

select distinct nhanvien.MaNV
from nhanvien
join chungnhan
on nhanvien.MaNV = chungnhan.MaNV
join maybay
on chungnhan.MaMB = maybay.MaMB
and Loai like 'Airbus%';

-- Cách 2:
SELECT DISTINCT c.MaNV
FROM chungnhan c
JOIN maybay m on c.MaMB = m.MaMB
WHERE Loai LIKE 'Boeing%'
AND c.MaNV IN(SELECT DISTINCT c.MaNV
               FROM chungnhan c
               JOIN maybay m on c.MaMB = m.MaMB
               WHERE Loai LIKE 'Airbus%');

-- Câu 13: Cho biết các loại máy bay có thể thực hiện chuyến bay VN280.
select maybay.Loai
from maybay
where maybay.TamBay>(select DoDai from chuyenbay where MaCB='VN280');

-- Câu 14: Cho biết các chuyến bay có thể được thực hiện bởi máy bay Airbus A320.
select *
from chuyenbay
where chuyenbay.DoDai < (select TamBay from maybay where Loai='Airbus A320');

-- Câu 15: Cho biết tên của các phi công lái máy bay Boeing. (btvn)
select distinct nhanvien.Ten
from nhanvien
join chungnhan c on nhanvien.MaNV = c.MaNV
join maybay m on c.MaMB = m.MaMB
where m.Loai like 'Boeing%';

-- Câu 16: Với mỗi loại máy bay có phi công lái cho biết mã số, loại máy báy và tổng số phi công có thể lái loại máy bay đó.(btvn)

-- Câu 17: Giả sử một hành khách muốn đi thẳng từ ga A đến ga B rồi quay trở về ga A.
--         Cho biết các đường bay nào có thể ñáp ứng yêu cầu này.
select * from chuyenbay a, chuyenbay b
where a.GaDi=b.GaDen and a.GaDen=b.GaDi;

-- Câu 18: Với mỗi ga có chuyến bay xuất phát từ đó cho biết có bao nhiêu chuyến bay khởi hành từ ga đó.
select count(MaCB), GaDi
from chuyenbay
group by GaDi;

-- Câu 19: Với mỗi ga có chuyến bay xuất phát từ đó cho biết tổng chi phí phải trả cho phi công lái các chuyến bay khởi hành từ ga đó.
select sum(ChiPhi), GaDi
from chuyenbay
group by GaDi;

-- Câu 20: Với mỗi địa điểm xuất phát cho biết có bao nhiêu chuyến bay có thể khởi hành trước 12:00. (btvn)
SELECT GaDi, COUNT(MaCB), GioDi
FROM chuyenbay
WHERE GioDi < '12:00:00'
group by (GaDi);

-- Câu 21: Cho biết mã số của các phi công chỉ lái được 3 loại máy bay (btvn)
SELECT *
FROM (SELECT MaNV, COUNT(MaMB) AS numberAirp FROM chungnhan GROUP BY (MaMB)) AS a
WHERE a.numberAirp = 3;


-- Câu 22: Với mỗi phi công có thể lái nhiều hơn 3 loại máy bay,
--         cho biết mã số phi công và tầm bay lớn nhất của các loại máy bay mà phi công đó có thể lái. (btvn)

SELECT a.MaNV, MAX(maybay.TamBay)
FROM (SELECT *, COUNT(MaMB) AS numberAirp FROM chungnhan GROUP BY (MaMB)) AS a
         JOIN maybay on a.MaMB = maybay.MaMB
    AND a.numberAirp > 3
GROUP BY (maybay.MaMB);


-- Câu 23: Với mỗi phi công cho biết mã số phi công và tổng số loại máy bay mà phi công đó có thể lái (btvn)
SELECT DISTINCT nhanvien.MaNV, nhanvien.Ten, COUNT(c.MaMB) AS TotalCategoryAirport
FROM nhanvien
         JOIN chungnhan c on nhanvien.MaNV = c.MaNV
GROUP BY c.MaNV;


-- Câu 24: Cho biết mã số của các phi công có thể lái được nhiều loại máy bay nhất. (btvn)
SELECT *
FROM (SELECT DISTINCT nhanvien.MaNV, nhanvien.Ten, COUNT(c.MaMB) AS TotalCategoryAirport
      FROM nhanvien
      JOIN chungnhan c on nhanvien.MaNV = c.MaNV
      GROUP BY c.MaNV) AS NV
      WHERE NV.TotalCategoryAirport = (SELECT MAX(NV2.TotalCategoryAirport)
                                       FROM (SELECT DISTINCT nhanvien.MaNV,
                                                       nhanvien.Ten,
                                                       COUNT(c.MaMB) AS TotalCategoryAirport
                                                       FROM nhanvien
                                                       JOIN chungnhan c on nhanvien.MaNV = c.MaNV
                                                       GROUP BY c.MaNV) AS NV2);


-- Câu 25: Cho biết mã số của các phi công có thể lái được ít loại máy bay nhất. (btvn)
SELECT *
FROM (SELECT DISTINCT nhanvien.MaNV, nhanvien.Ten, COUNT(c.MaMB) AS TotalCategoryAirport
      FROM nhanvien
               JOIN chungnhan c on nhanvien.MaNV = c.MaNV
      GROUP BY c.MaNV) AS NV
WHERE NV.TotalCategoryAirport = (SELECT MIN(NV2.TotalCategoryAirport)
                                 FROM (SELECT DISTINCT nhanvien.MaNV,
                                                       nhanvien.Ten,
                                                       COUNT(c.MaMB) AS TotalCategoryAirport
                                       FROM nhanvien
                                                JOIN chungnhan c on nhanvien.MaNV = c.MaNV
                                       GROUP BY c.MaNV) AS NV2);


-- Câu 26: Tìm các nhân viên không phải là phi công. (btvn)
SELECT *
FROM nhanvien
WHERE MaNV NOT IN (SELECT DISTINCT nhanvien.MaNV
                   FROM nhanvien
                   JOIN chungnhan c on nhanvien.MaNV = c.MaNV);


-- Câu 27: Cho biết mã số của các nhân viên có lương cao nhất. (btvn)
SELECT nhanvien.MaNV
FROM nhanvien
WHERE Luong = (SELECT MAX(nhanvien.Luong) FROM nhanvien);



-- Câu 28: Cho biết tổng số lương phải trả cho các phi công. (btvn)
SELECT COUNT(nhanvien.Luong)
FROM nhanvien
WHERE MaNV IN (SELECT DISTINCT nhanvien.MaNV
               FROM nhanvien
               JOIN chungnhan c on nhanvien.MaNV = c.MaNV);


-- Câu 29: Tìm các chuyến bay có thể được thực hiện bởi tất cả các loại máy bay Boeing. (btvn)
SELECT *
FROM chuyenbay
WHERE DoDai <= (SELECT MIN(TamBay) FROM maybay WHERE Loai LIKE "boeing%");


-- Câu 30: Cho biết mã số của các máy bay có thể được sử dụng để thực hiện chuyến bay từ Sài Gòn (SGN) đến Huế (HUI). (btvn)
SELECT MaMB
FROM maybay
WHERE TamBay >= (SELECT TamBay FROM chuyenbay WHERE GaDi = 'SGN' AND GaDen = 'HUI');


-- Câu 31: Tìm các chuyến bay có thể được lái bởi các phi công có lương lớn hơn 100,000 (btvn)
SELECT TamBay
FROM maybay
WHERE MaMB IN (SELECT DISTINCT MaMB
               FROM nhanvien
                        JOIN chungnhan c on nhanvien.MaNV = c.MaNV
               WHERE Luong > 100000);

-- Câu 32: Cho biết tên các phi công có lương nhỏ hơn chi phí thấp nhất của đường bay từ Sài Gòn (SGN) đến Buôn Mê Thuộc (BMV). (btvn)
SELECT DISTINCT nhanvien.Ten
FROM nhanvien
         JOIN chungnhan c on nhanvien.MaNV = c.MaNV
         WHERE Luong < (SELECT MIN(ChiPhi) FROM chuyenbay WHERE GaDi = 'SGN' AND GaDen = 'BMV');


-- Câu 33: Cho biết mã số của các phi công có lương cao nhất. (btvn)
SELECT DISTINCT nhanvien.MaNV
FROM nhanvien
         JOIN chungnhan c on nhanvien.MaNV = c.MaNV
WHERE Luong = (SELECT MAX(Luong)
               FROM nhanvien
                        JOIN chungnhan c on nhanvien.MaNV = c.MaNV);


-- Câu 34: Cho biết mã số của các nhân viên có lương cao thứ nhì (btvn)
SELECT *
FROM nhanvien
WHERE Luong = (SELECT MAX(luong) FROM nhanvien WHERE Luong < (SELECT MAX(luong) FROM nhanvien));


-- Câu 35: Cho biết mã số của các nhân viên có lương cao thứ nhất hoặc thứ nhì. (btvn)
SELECT *
FROM nhanvien
WHERE Luong = (SELECT MAX(luong) FROM nhanvien)
   OR Luong = (SELECT MAX(luong) FROM nhanvien WHERE Luong < (SELECT MAX(luong) FROM nhanvien));


-- Câu 36: Cho biết tên và lương của các nhân viên không phải là phi công và có lương lớn hơn lương trung bình của tất cả các phi công. (btvn)
SELECT COUNT(PC.MaNV)
FROM (SELECT DISTINCT nhanvien.MaNV
      FROM nhanvien
      JOIN chungnhan c on nhanvien.MaNV = c.MaNV) AS PC;

-- Câu 37: Cho biết tên các phi công có thể lái các máy bay có tầm bay lớn hơn 4,800km nhưng không có chứng nhận lái máy bay Boeing. (btvn)


-- Câu 38: Cho biết tên các phi công lái ít nhất 3 loại máy bay có tầm bay xa hơn 3200km. (btvn)

-- Câu 39: Với mỗi nhân viên cho biết mã số, tên nhân viên và tổng số loại máy bay mà nhân viên đó có thể lái. (btvn)
SELECT Ten, nhanvien.MaNV, COUNT(m.Loai)
FROM nhanvien
         JOIN chungnhan c on nhanvien.MaNV = c.MaNV
         JOIN maybay m on c.MaMB = m.MaMB
GROUP BY (nhanvien.MaNV);


-- Câu 40: Với mỗi nhân viên cho biết mã số, tên nhân viên và tổng số loại máy bay Boeing mà nhân viên đó có thể lái. (btvn)
SELECT Ten, nhanvien.MaNV, COUNT(m.Loai)
FROM nhanvien
         JOIN chungnhan c on nhanvien.MaNV = c.MaNV
         JOIN maybay m on c.MaMB = m.MaMB
WHERE m.Loai LIKE "Boeing%"
GROUP BY (nhanvien.MaNV);


-- Câu 41: Với mỗi loại máy bay cho biết loại máy bay và tổng số phi công có thể lái loại máy bay đó (btvn)
SELECT Loai, COUNT(MaNV)
FROM maybay
         JOIN chungnhan c on maybay.MaMB = c.MaMB
GROUP BY (Loai);


-- Câu 42: Với mỗi loại máy bay cho biết loại máy bay và tổng số chuyến bay không thể thực hiện bởi loại máy bay đó (btvn)

-- Câu 43: Với mỗi loại máy bay cho biết loại máy bay và tổng số phi công có lương lớn hơn 100,000 có thể lái loại máy bay đó. (btvn)
SELECT Loai, MB2.TongPC
FROM maybay
         JOIN (SELECT DISTINCT C.MaMB, COUNT(c.MaNV) AS TongPC
               FROM nhanvien
                        JOIN chungnhan c on nhanvien.MaNV = c.MaNV
               WHERE Luong > 100000
               GROUP BY (MaMB)) AS MB2 ON maybay.MaMB = MB2.MaMB;


-- Câu 44: Với mỗi loại máy bay có tầm bay trên 3200km,
--         cho biết tên của loại máy bay và lương trung bình của các phi công có thể lái loại máy bay đó. (btvn)

-- Câu 45: Với mỗi loại máy bay cho biết loại máy bay và tổng số nhân viên không thể lái loại máy bay đó (btvn)

-- Câu 46: Với mỗi loại máy bay cho biết loại máy bay và tổng số phi công không thể lái loại máy bay đó (btvn)

-- Câu 47: Với mỗi nhân viên cho biết mã số, tên nhân viên và tổng số chuyến bay xuất phát từ Sài Gòn mà
--         nhân viên đó có thể lái. (btvn)

-- Câu 48: Với mỗi nhân viên cho biết mã số, tên nhân viên và tổng số chuyến bay xuất phát từ Sài Gòn mà nhân viên đó không thể lái. (btvn)

-- Câu 49: Với mỗi phi công cho biết mã số, tên phi công và tổng số chuyến bay xuất phát từ Sài Gòn mà phi công đó có thể lái.

-- Câu 50: Với mỗi phi công cho biết mã số, tên phi công và tổng số chuyến bay xuất phát từ Sài Gòn mà
--         phi công đó không thể lái.

-- Câu 51: Với mỗi chuyến bay cho biết mã số chuyến bay và tổng số loại máy bay không thể thực hiện chuyến bay đó.

-- Câu 52: Với mỗi chuyến bay cho biết mã số chuyến bay và tổng số loại máy bay có thể thực hiện chuyến bay đó.

-- Câu 53: Với mỗi chuyến bay cho biết mã số chuyến bay và tổng số nhân viên không thể lái chuyến bay đó

-- Câu 54: Với mỗi chuyến bay cho biết mã số chuyến bay và tổng số phi công không thể lái chuyến bay đó.

-- Câu 55: Một hành khách muốn ñi từ Hà Nội (HAN) ñến Nha Trang (CXR) mà không phải ñổi chuyến bay
--         quá một lần. Cho biết mã chuyến bay và thời gian khởi hành từ Hà Nội nếu hành khách muốn
--         đến Nha Trang trước 16:00.

-- Câu 56: Cho biết tên các loại máy bay mà tất cả các phi công có thể lái ñều có lương lớn hơn 200,000.

-- Câu 57: Cho biết thông tin của các đường bay mà tất cả các phi công có thể bay trên đường bay đó ñều có
--         lương lớn hơn 100,000.

-- Câu 58: Cho biết tên các phi công chỉ lái các loại máy bay có tầm bay xa hơn 3200km.

-- Câu 59: Cho biết tên các phi công chỉ lái các loại máy bay có tầm bay xa hơn 3200km và một trong số đó là Boeing.

-- Câu 60: Tìm các phi công có thể lái tất cả các loại máy bay.

-- Câu 61: Tìm các phi công có thể lái tất cả các loại máy bay Boeing.

