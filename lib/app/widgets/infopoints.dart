import 'package:flutter/material.dart';
import 'package:sonhador/app/utils/colors.dart';
import 'package:sonhador/app/utils/fonts.dart';
import 'package:sonhador/app/utils/points.dart';

void showInfo(BuildContext pageContext) {
  showDialog(
      context: pageContext,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: secondary_color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            scrollable: true,
            content: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informações sobre os pontos',
                      style: h1Light,
                    ),
                    Divider(),
                    Text(
                      'Uma curtida = ${points['like']} ${points['like'] > 1 ? 'pontos' : 'ponto'}',
                      style: smallStyleLight,
                    ),
                    Text(
                      'Um compartilhamento = ${points['share']} ${points['share'] > 1 ? 'pontos' : 'ponto'}',
                      style: smallStyleLight,
                    ),
                    // Text(
                    //   'Uma visualização = ${points['view']} ${points['view'] > 1 ? 'pontos' : 'ponto'}',
                    //   style: smallStyleLight,
                    // ),
                    Text(
                      'Um comentário = ${points['comment']} ${points['comment'] > 1 ? 'ponto' : 'ponto'}',
                      style: smallStyleLight,
                    ),
                    Divider(),
                    Text(
                      '10000 pontos em seu texto = R\$ 10,00 p/você',
                      style: smallStyleSuccess,
                    ),
                    Text(
                      'Você no Top 1 da semana = R\$ 15,00 p/você',
                      style: smallStyleSuccess,
                    ),
                    Text(
                      'Você no Top 2 da semana = R\$ 10,00 p/você',
                      style: smallStyleSuccess,
                    ),
                    Text(
                      'Você no Top 3 da semana = R\$ 5,00 p/você',
                      style: smallStyleSuccess,
                    )
                  ],
                )));
      });
}
