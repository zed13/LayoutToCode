import 'package:flutter/material.dart';
import 'package:layout_convert/base.dart';
import 'package:layout_convert/view_model.dart';

class Additions extends StatefulWidget {
  final ViewModel viewModel;

  Additions({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AdditionsState(viewModel);
}

class _AdditionsState extends RxState<Additions> {
  final ViewModel vm;

  _AdditionsState(this.vm);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text("Additions", style: TextStyle(fontSize: 16)),
          _inputField(
            labelText: "Prefix",
            controller: vm.prefixController,
          ),
          _inputField(
            labelText: "Postfix",
            controller: vm.postfixController,
          ),
          _inputField(
            labelText: "Parent view",
            controller: vm.parentViewController,
          )
        ],
      ),
    );
  }
}

Widget _inputField({
  @required String labelText,
  @required TextEditingController controller,
}) {
  return Container(
    padding: EdgeInsets.only(top: 16),
    child: SizedBox(
      width: 200,
      height: 42,
      child: TextFormField(
        controller: controller,
        maxLines: 1,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    ),
  );
}
