import 'package:flutter/material.dart';

class SearchableComboBox extends StatefulWidget {
  final String label;
  final List<String> options;
  final String? initialValue;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;

  const SearchableComboBox({
    super.key,
    required this.label,
    required this.options,
    required this.onChanged,
    this.initialValue,
    this.validator,
  });

  @override
  State<SearchableComboBox> createState() => _SearchableComboBoxState();
}

class _SearchableComboBoxState extends State<SearchableComboBox> {
  TextEditingController? _ctrl;

  void _attach(TextEditingController ctrl) {
    if (_ctrl == ctrl) return;
    _ctrl?.removeListener(_notify);
    _ctrl = ctrl;
    _ctrl!.addListener(_notify);
  }

  void _notify() {
    if (_ctrl != null) widget.onChanged(_ctrl!.text);
  }

  @override
  void dispose() {
    _ctrl?.removeListener(_notify);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      initialValue: TextEditingValue(text: widget.initialValue ?? ''),
      optionsBuilder: (tv) {
        final q = tv.text.toLowerCase();
        if (q.isEmpty) return widget.options;
        return widget.options.where((o) => o.toLowerCase().contains(q));
      },
      onSelected: widget.onChanged,
      fieldViewBuilder: (ctx, ctrl, focusNode, _) {
        _attach(ctrl);
        return TextFormField(
          controller: ctrl,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: widget.label,
            suffixIcon: widget.options.isNotEmpty ? const Icon(Icons.arrow_drop_down) : null,
          ),
          textCapitalization: TextCapitalization.words,
          validator: widget.validator,
        );
      },
      optionsViewBuilder: (ctx, onSelected, options) => Align(
        alignment: Alignment.topLeft,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(12),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(ctx).size.height * 0.5),
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: options.length,
                itemBuilder: (_, i) {
                  final option = options.elementAt(i);
                  return InkWell(
                    onTap: () => onSelected(option),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Text(option),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
