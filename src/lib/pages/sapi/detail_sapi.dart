import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:src/common/helper/date_formatter.dart';
import 'package:src/common/helper/gender.dart';
import 'package:src/common/helper/util.dart';
import 'package:src/common/style/text_style.dart';
import 'package:src/common/widget/sapi_saya_widget.dart';
import 'package:src/controller/recording/add_sapi_controller.dart';
import 'package:src/controller/sapi/sapi_saya_controller.dart';

import '../../common/model/sapi_model.dart';
import '../../controller/sapi/detail_sapi_controller.dart';

class DetailSapi extends StatelessWidget {
  const DetailSapi({Key? key}) : super(key: key);

  Widget body(String title, String body, {Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: kText14Style,
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              body != "" ? body : "-",
              style: onTap != null
                  ? kText14Style.copyWith(
                      color: Colors.amber,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)
                  : kText14Style,
            ),
          )
        ],
      ),
    );
  }

  Widget _cardIdentitas(CowModel e) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Identitas Kelahiran',
              style: kText20StyleBold.copyWith(color: Colors.black),
            ),
            Divider(),
            body('Kode', e.uniqueId ?? '-'),
            body('Nama', e.name ?? '-'),
            body('Bangsa', e.breed ?? '-'),
            body('Jenis Kelamin', e.gender != null ? gender(e.gender!) : '-'),
            body('Warna', e.color ?? '-'),
            body(
              'Induk',
              e.parentF ?? '-',
              onTap: () {
                print('Navigate to ${e.parentF}');
              },
            ),
            body(
              'Pejantan',
              e.parentM ?? '-',
              onTap: () {},
            ),
            body(
                'Tanggal Lahir',
                (e.birthdate != null && e.birthdate != "")
                    ? CustomDateFormat.dateDMY
                        .format(DateTime.parse(e.birthdate!))
                    : '-'),
            body('Umur', e.name ?? '-'),
            body('Bobot Lahir', (e.weightBirth ?? 0).toString()),
          ],
        ),
      ),
    );
  }

  Widget _dataTubuh(CowModel e) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Tubuh',
              style: kText20StyleBold.copyWith(color: Colors.black),
            ),
            Divider(),
            body('Bobot Saat umur 4 bulan',
                (e.weight4Mo != null ? e.weight4Mo! : '-').toString() + ' kg'),
            body('Bobot Saat umur 1 tahun',
                (e.weight1Yo != null ? e.weight1Yo! : '-').toString() + ' kg'),
            body(
                'Lingkar Dada saat umur 1 tahun',
                e.chestCircumference1Yo != null
                    ? (e.chestCircumference1Yo.toString() + ' cm')
                    : '-'),
            body(
                'Panjang Badan saat umur 1 tahun',
                e.bodyLength1Yo != null
                    ? (e.bodyLength1Yo.toString() + ' cm')
                    : '-'),
            body(
                'Tinggi Pundak saat umur 1 tahun',
                e.gumbaHeight1Yo != null
                    ? (e.gumbaHeight1Yo.toString() + ' cm')
                    : '-'),
          ],
        ),
      ),
    );
  }

  Widget _catatan(CowModel e) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Catatan',
              style: kText20StyleBold.copyWith(color: Colors.black),
            ),
            Divider(),
            SizedBox(
              height: 150,
              child: Text(
                e.notes ?? '-',
                style: kText14Style,
                textAlign: TextAlign.justify,
                maxLines: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DetailSapiController(),
      builder: (DetailSapiController controller) {
        var data = controller.cow.value;
        return Scaffold(
            appBar: AppBar(
              title: Text((data.name ?? '-').capitalizeFirst!),
              actions: [
                IconButton(
                  onPressed: () async {
                    var res = await Get.toNamed(
                      '/add-sapi',
                      arguments: AddSapiArguments(editData: data),
                    );
                    print('res is $res');
                    if (res != null) {
                      Get.find<SapiSayaController>().init();
                    }
                  },
                  icon: Icon(
                    Icons.edit_sharp,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _cardIdentitas(data),
                    _dataTubuh(data),
                    _catatan(data)
                  ],
                ),
              ),
            ));
      },
    );
  }
}
