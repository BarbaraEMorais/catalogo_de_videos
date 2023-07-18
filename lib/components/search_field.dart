import 'package:catalogo_de_videos/styles/theme_colors.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: TextField(
                      onTap: () => {print(_searchController.text)},
                      onTapOutside: ((event) {
                        FocusScope.of(context).unfocus();
                      }),
                      controller: _searchController,
                      keyboardType: TextInputType.text,
                      cursorColor: ThemeColors.text,
                      decoration: InputDecoration(
                          label: Text("Pesquisar",
                              style: TextStyle(color: ThemeColors.text)),
                          suffixIcon:
                              Icon(Icons.search, color: ThemeColors.text),
                          border: InputBorder.none),
                      style: TextStyle(color: ThemeColors.text),
                    )))),
      ],
    );
  }
}
