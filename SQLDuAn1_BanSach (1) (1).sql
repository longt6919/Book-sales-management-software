create database duan1_Nhom3_BanSach2


/*Nhân viên */
CREATE TABLE [dbo].[ChucVu]
(	
	[Id] bigint PRIMARY KEY IDENTITY(1,1),
	[Ma] [nvarchar](30) NOT NULL,
	[Ten] [nvarchar](30) NOT NULL,
	[TrangThai] [nvarchar](100) NULL,
	MucLuong float
)
insert into ChucVu(ma,ten,MucLuong) values ('CV01',N'Quản lý',30000)
insert into ChucVu(ma,ten,MucLuong) values ('CV02',N'Nhân viên',25000)

CREATE TABLE [dbo].[NhanVien]
(
	[Id] bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[IdChucVu] bigint NOT NULL,
	[Ma] [nvarchar](30) NOT NULL,
	[Ten] [nvarchar](30) NOT NULL,
	[GioiTinh] [nvarchar](5) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[SDT] [nvarchar](12) NOT NULL,
	[DiaChi] [nvarchar](100) NOT NULL,
	[MatKhau] [nvarchar](32),
	[TrangThaiDiLam] [int] NOT NULL,
	[TrangThaiShipper] [int] NOT NULL
)

CREATE TABLE [dbo].[BANGLUONG]
(	
	[Id] bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[IdNhanVien] bigint NOT NULL,
	[TongTienPhat] float,
	[TongTienThuong] float,
	[TongTienCong] float,
	[Thang] int,
)
ALTER TABLE [dbo].[BANGLUONG] ADD  [TrangThai] int

CREATE TABLE [dbo].[PHIEUPHAT]
(	
	[Id] bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[LyDo] [nvarchar](50) NOT NULL,
	[Muc] float NOT NULL,
	[TrangThai] [int]
	
)
CREATE TABLE [dbo].[PHIEUTHUONG]
(	
	[Id] bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[LyDo] [nvarchar](50) NOT NULL,
	[Muc] float NOT NULL,
	[TrangThai] [int] 
	
)

CREATE TABLE [dbo].[CTPhatTHUONG]
(	
	[Id] bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[IdNhanVien] bigint NOT NULL,
	[IdPhieuTHUONG] bigint ,
	[IdPhieuPhat] bigint ,
	[TrangThai] [int],
	[NgayPhat] [date] NOT NULL,
	
)

CREATE TABLE [dbo].[ChamCong]
(	
	[Id] bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[IdNhanVien] bigint NOT NULL,
	[NgayLam] [date] NOT NULL,
	[GioIN] [datetime] ,
	[GioOUT] [datetime],
	
	[TrangThai] [int] NOT NULL
)
ALTER TABLE [dbo].[ChamCong] ADD TrangThaiTinhLuong int
ALTER TABLE [dbo].[NhanVIen] ADD  FOREIGN KEY([IdChucVu])
REFERENCES [dbo].[ChucVu] ([Id])
ALTER TABLE [dbo].[BangLuong] ADD  FOREIGN KEY([IdNhanVien])
REFERENCES [dbo].[NhanVien] ([Id])
ALTER TABLE [dbo].[CTPhatTHUONG] ADD  FOREIGN KEY([IdNhanVien])
REFERENCES [dbo].[NhanVien] ([Id])
ALTER TABLE [dbo].[CTPhatTHUONG] ADD  FOREIGN KEY([IdPhieuTHUONG])
REFERENCES [dbo].[PhieuThuong] ([Id])
ALTER TABLE [dbo].[CTPhatTHUONG] ADD  FOREIGN KEY([IdPhieuPhat])
REFERENCES [dbo].[PhieuPhat] ([Id])
ALTER TABLE [dbo].[ChamCong] ADD  FOREIGN KEY([IdNhanVien])
REFERENCES [dbo].[NhanVien] ([Id])

/*Khách hàng */

CREATE TABLE [dbo].[KhachHang](

	[Id] bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Ma] [nvarchar](30)  NOT NULL UNIQUE ,
	[Ten] [nvarchar](30) NOT NULL,
	[GioiTinh] [nvarchar](5) NOT NULL,
	[Email] [nvarchar](100) DEFAULT NULL UNIQUE,
	[SDT] [nvarchar](12) NOT NULL UNIQUE,
	[IdCapBac]bigint DEFAULT NULL,
	[NgayTao] [Date] NOT NULL
)

CREATE TABLE [dbo].[CapBac]
(
	[Id] bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Ma] [nvarchar](10)  NOT NULL ,
	[MucGiam] [float] Default NULL,
	[Ten] [nvarchar](10) NOT NULL,	
)

drop table CapBac

insert into CapBac(Ma,Ten,MucGiam) values ('CB01',N'Thường',0)
insert into CapBac(Ma,Ten,MucGiam) values ('CB02',N'VIP',0.05)

CREATE TABLE [dbo].[ThongTinChiTiet](
	[Id] bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[is_primary] [int] NOT NULL,
	[IdKhachHang] bigint,
	[SDT] [nvarchar](12) NOT NULL,
	[DiaChi] [nvarchar](100) NOT NULL,
	[ThanhPho] [nvarchar](100) NOT NULL,	
	[NgayTao] [Date] NOT NULL
)
drop table ThongTinChiTiet
ALTER TABLE [dbo].[KhachHang] ADD  FOREIGN KEY([IdCapBac])
REFERENCES [dbo].[CapBac] ([Id])

ALTER TABLE [dbo].[ThongTinChiTiet] ADD  FOREIGN KEY([IdKhachHang])
REFERENCES [dbo].[KhachHang] ([Id])



/*Hóa đơn */

CREATE TABLE [dbo].[HoaDon]
(
	[Id] bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[IdNhanVien] [bigint] NOT NULL,
	[IdKM] [bigint]  NULL,
	[IdKhachHang] bigint NULL,
	[IdHinhThucThanhToan] bigint NULL,
	[Ma] [nvarchar](30) NOT NULL,
	[NgayTao] [datetime] NOT NULL,
    [IdTrangThaiHD] [bigint] NOT NULL,
	[TongTien] [int]

)

CREATE TABLE TrangThaiHoaDon
(
	[Id] bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Ten] [nvarchar](20)
)
drop table TrangThaiHoaDon
ALTER TABLE [dbo].[HoaDon] ADD  FOREIGN KEY([IdTrangThaiHD])
REFERENCES [dbo].[TrangThaiHoaDon] ([Id])

--ALTER TABLE HoaDon
--ALTER COLUMN NgayTao Datetime
--select*from HoaDon

--drop table HoaDon
--ALTER TABLE HoaDon
--ADD IdTrangThaiHD bigint ;
--ALTER TABLE HoaDon
--Drop Column IdTrangThai;
--select*from HoaDon

CREATE TABLE [dbo].[HoaDonChiTiet](
	[Id] bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[IdHoaDon] bigint NOT NULL,
	[IdCTSach] bigint NOT NULL,
	[SoLuong] [bigint] NOT NULL,
	
	
)
CREATE TABLE [dbo].[HinhThucThanhToan]
(
	[Id] bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Ma] [nvarchar](30) NOT NULL,
	[TenHinhThucThanhToan] [nvarchar](30) NOT NULL,
	[TrangThai] [int] NOT NULL,
)

ALTER TABLE [dbo].[HoaDon] ADD  FOREIGN KEY([IdNhanVien])
REFERENCES [dbo].[NhanVien] ([Id])
ALTER TABLE [dbo].[HoaDon] ADD  FOREIGN KEY([IdKhachHang])
REFERENCES [dbo].[KhachHang] ([Id])
ALTER TABLE [dbo].[HoaDon] ADD  FOREIGN KEY([IdHinhThucThanhToan])
REFERENCES [dbo].[HinhThucThanhToan] ([Id])
ALTER TABLE [dbo].[HoaDonChiTiet] ADD  FOREIGN KEY([IdHoaDon])
REFERENCES [dbo].[HoaDon] ([Id])
ALTER TABLE [dbo].[HoaDonChiTiet] ADD  FOREIGN KEY([IdCTSach])
REFERENCES [dbo].[CTSach] ([IdCTSach])
/* Giao Hàng*/

CREATE TABLE TrangThaiPhieuGiaoHang
(
    id bigint IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50)
);
	
CREATE TABLE PhieuGiaoHang
(
    id bigint IDENTITY(1,1) PRIMARY KEY,
	idNV bigint ,
	idTrangThai bigint,
    sdtNguoiNhan VARCHAR(20) not null,
    diaChiNguoiNhan NVARCHAR(200) not null,
    ngayTaoPhieu DATETIME,
    ghiChu NVARCHAR(100),
    tienCuoc float,
    hoaDonId bigint, 
   

);

create table LichSuCapNhatTrangThai
(
	idPGH bigint,
	idNV bigint,
	NgayCapNhat date,
	FOREIGN KEY (idPGH) REFERENCES PhieuGiaoHang(id),
	FOREIGN KEY (idNV) REFERENCES NhanVien(id)
)


CREATE TABLE LichSuGiaoHang
(
    ngayGiaoHang DATE,
    trangThai NVARCHAR(50),
    ghiChu NVARCHAR(200),
    phieuGiaoHangId bigint,
    idNVGH bigint,
   FOREIGN KEY (phieuGiaoHangId) REFERENCES PhieuGiaoHang(id),
  FOREIGN KEY (idNVGH) REFERENCES NhanVien(id)
);
ALTER TABLE [dbo].[PhieuGiaoHang] ADD  FOREIGN KEY([HoaDonID])
REFERENCES [dbo].[HoaDon] ([Id])
ALTER TABLE [dbo].[PhieuGiaoHang] ADD  FOREIGN KEY([idNV])
REFERENCES [dbo].[NhanVien] ([Id])
ALTER TABLE [dbo].[PhieuGiaoHang] ADD  FOREIGN KEY([idTrangThai])
REFERENCES [dbo].[TrangThaiPhieuGiaoHang] ([Id])
ALTER TABLE [dbo].[PhieuGiaoHang] ADD  FOREIGN KEY([idTrangThai])
REFERENCES [dbo].[TrangThaiPhieuGiaoHang] ([Id])


CREATE TABLE DotKhuyenMai(
Id bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
idNV bigint,
Ma VARCHAR(20) UNIQUE,
Ten NVARCHAR(50) NULL,
PhanTramKM float,
NgayBatDau DATE NULL,
NgayKetThuc DATE NULL,
TrangThai nvarchar(50) NULL,
NgayTao datetime
)
go
drop table DotKhuyenMai 
ALTER TABLE [dbo].[HoaDon] ADD  FOREIGN KEY([IdKM])
REFERENCES [dbo].[DotKhuyenMai] ([Id])
select*from DotKhuyenMai
/*SÁCH*/

CREATE TABLE [dbo].[CTSach]
(
	[IdCTSach] bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[IdNXB] bigint NOT NULL,
	[IdViTri] bigint NOT NULL,	
	[IdSach] bigint NOT NULL,
	[IdNamXuatBan] bigint NOT NULL,
	[IdChatLieu] bigint NOT NULL,
	[IdNgonNgu] bigint NOT NULL,
	[SoLuong] [int] NOT NULL,	
	[GiaBan] [decimal](38, 5) NOT NULL,
	[TrangThai] [int] NOT NULL,
	[Hinh] [varchar] NULL,
	[MoTa] [nvarchar](100) NULL,
	[SoTrang] [int] NULL
)


CREATE TABLE [dbo].[ViTri]
(
	[Id] bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Ma] [nvarchar](30) NOT NULL,
	[MoTa] [nvarchar](100) NULL,
	[Ten] [nvarchar](50) NOT NULL
)

CREATE TABLE [dbo].[NhaXuatBan]
(
	[Id] bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Ma] [nvarchar](30) NOT NULL,
	[Ten] [nvarchar](50) NOT NULL,
	[MoTa] [nvarchar](100) NULL
)

CREATE TABLE [dbo].[NamXuatBan]
(
	[Id] bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Ma] [nvarchar](30) NOT NULL,
	[Nam] [varchar](4) NOT NULL,
)
ALTER TABLE [NamXuatBan] 
add  [MoTa] [nvarchar](100) NULL
CREATE TABLE [dbo].[NgonNgu]
(
	[Id] bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Ma] [nvarchar](30) NOT NULL,
	[Ten] [nvarchar](50) NOT NULL,
	[MoTa] [nvarchar](100) NULL
)

CREATE TABLE [dbo].[ChatLieu]
(
	[Id] bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Ma] [nvarchar](30) NOT NULL,
	[Ten] [nvarchar](50) NOT NULL,
	[MoTa] [nvarchar](100) NULL
)





CREATE TABLE [dbo].[Sach]
(
	[Id] bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Ma] [nvarchar](30) NOT NULL,
	[Ten] [nvarchar](50) NOT NULL,
	
	[MoTa] [nvarchar](100) NULL
)

CREATE TABLE TacGiaSach(
	[Id] bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
	idTacGia bigint,
	idSach bigint
)
CREATE TABLE [dbo].[TacGia]
(
	[Id] bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Ma] [nvarchar](30) NOT NULL,
	[Ten] [nvarchar](50) NOT NULL,
	[MoTa] [nvarchar](100) NULL
)

CREATE TABLE ChiTietTheLoai(
	[Id] bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
	idTheLoai bigint,
	idSach bigint
)

CREATE TABLE [dbo].[TheLoai]
(
	[Id] bigint PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Ma] [nvarchar](30) NOT NULL,
	[Ten] [nvarchar](50) NOT NULL,
	[MoTa] [nvarchar](100) NULL
)

ALTER TABLE [dbo].[CTSach] ADD  FOREIGN KEY([IdSach])
REFERENCES [dbo].[Sach] ([Id])
ALTER TABLE [dbo].[CTSach] ADD  FOREIGN KEY([IdNXB])
REFERENCES [dbo].[NhaXuatBan] ([Id])
ALTER TABLE [dbo].[CTSach] ADD  FOREIGN KEY([IdViTri])
REFERENCES [dbo].[ViTri] ([Id])
ALTER TABLE [dbo].[CTSach] ADD  FOREIGN KEY([IdNamXuatBan])
REFERENCES [dbo].[NamXuatBan] ([Id])
ALTER TABLE [dbo].[CTSach] ADD  FOREIGN KEY([IdChatLieu])
REFERENCES [dbo].[ChatLieu] ([Id])
ALTER TABLE [dbo].[CTSach] ADD  FOREIGN KEY([IdNgonNgu])
REFERENCES [dbo].[NgonNgu] ([Id])
ALTER TABLE [dbo].TacGiaSach ADD  FOREIGN KEY([IdTacGia])
REFERENCES [dbo].[TacGia] ([Id])
ALTER TABLE [dbo].TacGiaSach ADD  FOREIGN KEY([IdSach])
REFERENCES [dbo].[Sach] ([Id])
ALTER TABLE [dbo].ChiTietTheLoai ADD  FOREIGN KEY([IdSach])
REFERENCES [dbo].[Sach] ([Id])
ALTER TABLE [dbo].ChiTietTheLoai ADD  FOREIGN KEY([IdTheLoai])
REFERENCES [dbo].[TheLoai] ([Id])


drop table CTSach
Drop table ChatLieu
Drop table TacGiaSach

drop table NamXuatBan
drop table ChiTietTheLoai
	ALTER TABLE KhachHang
	DROP CONSTRAINT FK__KhachHang__IdCap__7D439ABD



