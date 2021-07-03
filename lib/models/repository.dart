class Plant {
  final String id;
  final String name;
  final String imgUrl;
  final double price;
  final int height;
  final int wight;

  Plant(this.id, this.name, this.imgUrl, this.price, this.height, this.wight);
}

class CartPlant {
  final String id;
  final String name;
  final int price;
  final int height;
  final int wight;

  CartPlant(this.id, this.name, this.price, this.height, this.wight);
}

class Repository {
  late List<Plant> plants;

  Repository() {
    initializeRepository();
  }

  initializeRepository() {
    plants = [
      Plant(
          "1",
          "Gasteri Kyoryu",
          "https://clipart-best.com/img/bush/bush-clip-art-2.png",
          228,
          300,
          310),
      Plant(
          "2",
          "Astrophytum",
          "https://www.pinclipart.com/picdir/big/86-863584_potted-plants-clipart-transparent-background-transparent-background-plants.png",
          228,
          230,
          340),
      Plant(
          "3",
          "Kyoryu Astrophytum",
          "https://im0-tub-ru.yandex.net/i?id=251f7e5643363cda9a923486d0afebfb&n=13",
          228,
          300,
          310),
      Plant(
          "4",
          "Gasteri ",
          "https://static.tildacdn.com/tild3139-6238-4066-b338-353034316232/hotpngcom_6.png",
          228,
          300,
          310)
    ];
  }
}
