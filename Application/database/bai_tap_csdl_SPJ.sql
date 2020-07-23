-- Câu 1: Cho biết quy cách màu và thành phố của các vật tư không được trữ tại Hà Nội có trọng lượng lớn hơn 10.
select Mau, ThPho
from VATTU
where ThPho like 'Ha Noi%' and TrLuong>10;

-- Câu 2: Cho biết thông tin chi tiết của tất cả các dự án.
select *
from DUAN;

-- Câu 3: Cho biết thông tin chi tiết của tất cả các dự án ở TpHCM
select *
from DUAN
where ThPho like 'TpHCM%';

-- Câu 4: Cho biết tên nhà cung cấp cung cấp vật tư cho dự án J1.
select N.MaNCC, N.Ten, CUNGCAP.MaDA
from CUNGCAP
       join NCC N on CUNGCAP.MaNCC = N.MaNCC
        where MaDA = 'J1';

-- Câu 5: Cho biết tên nhà cung cấp, tên vật tư và tên dự án mà số lượng vật tư
--        được cung cấp cho dự án bởi nhà cung cấp lớn hơn 300 và nhỏ hơn 750

select NCC.Ten as TenNCC, VATTU.Ten as TenVattu, DUAN.Ten as TenDuan
from CUNGCAP
join NCC on CUNGCAP.MaNCC = NCC.MaNCC
join duan on CUNGCAP.MaDA = DUAN.MaDA
join vattu on CUNGCAP.MaVT = VATTU.MaVT
where CUNGCAP.SLuong > 300 and CUNGCAP.SLuong < 700;

-- Câu 6: Cho biết thông tin chi tiết của các vật tư được cung cấp bởi các nhà cung cấp ở TpHCM.
select VATTU.*
from VATTU
join cungcap on VATTU.MaVT = CUNGCAP.MaVT
join NCC N on CUNGCAP.MaNCC = N.MaNCC
where N.ThPho='TpHCM';

-- Câu 7: Cho biết mã số các vật tư được cung cấp cho các dự án tại TpHCM bởi các nhà cung cấp ở TpHCM.
select VATTU.MaVT
from CUNGCAP
join VATTU on CUNGCAP.MaVT = VATTU.MaVT
join NCC N on CUNGCAP.MaNCC = N.MaNCC
join duan on CUNGCAP.MaDA = DUAN.MaDA
where DUAN.ThPho = 'TpHCM' and N.ThPho='TpHCM';

-- Câu 8: Liệt kê các cặp tên thành phố mà nhà cung cấp ở thành phố thứ nhất cung cấp vật tư được trữ tại thành phố thứ hai.

-- Câu 9: Liệt kê các cặp tên thành phố mà nhà cung cấp ở thành phố thứ nhất cung cấp vật tư cho dự án tại thành phố thứ hai.

-- Câu 10: Liệt kê các cặp mã số nhà cung cấp ở cùng một thành phố.

select top (2) MaNCC
from NCC
where ThPho='TpHCM';