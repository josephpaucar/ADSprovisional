import 'package:flutter/material.dart';
import 'package:aves_de_san_martin/models/app_data.dart';

class ServicesTwoColumnGridBuilder extends StatelessWidget {
  ServicesTwoColumnGridBuilder({super.key});
  final List<Service> services = Service.services;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 220),
        itemCount: services.length,
        itemBuilder: ((_, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                Ink(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(services[index].imageUrl),
                        fit: BoxFit.cover,
                      )),
                  child: InkWell(
                    onTap: () {},
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.black54.withOpacity(0.3),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      services[index].nombre,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          color: Colors.white),
                    ))
              ],
            ),
          );
        }));
  }
}
