class Laundry {
  int id;
  String nama;
  String emailUser;
  String lokasi;
  int berat;
  String kategori;
  String kategoriPengerjaan;
  int sudahBayar;
  String statusPengerjaan;
  int harga;
  String date;

  Laundry.fromJson(Map json) {
    print(json);
    this.id = json['id'];
    this.nama = json['nama'];
    this.emailUser = json['emailUser'];
    this.lokasi = json['lokasi'];
    this.berat = json['berat'];
    this.kategori = json['kategori'];
    this.kategoriPengerjaan = json['kategoriPengerjaan'];
    this.sudahBayar = json['sudahBayar'];
    this.statusPengerjaan = json['statusPengerjaan'];
    this.harga = json['harga'];
    this.date = json['date'];
  }
}
