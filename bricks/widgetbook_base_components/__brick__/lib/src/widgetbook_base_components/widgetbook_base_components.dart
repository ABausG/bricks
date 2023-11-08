import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class BaseComponents {}

class BaseComponentList extends StatelessWidget {
  const BaseComponentList({super.key, required this.components});

  final Map<String, Map<String, Widget>> components;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListView.separated(
        itemCount: components.length,
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, index) {
          final e = components.entries.elementAt(index);
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                e.key,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                children: e.value.entries
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            e.value,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                e.key,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}

@widgetbook.UseCase(name: 'Buttons', type: BaseComponents)
Widget buttonsBaseComponents(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Label',
  );
  final buttons = {
    'Elevated Button': {
      'Enabled': ElevatedButton(
        onPressed: () {},
        child: Text(label),
      ),
      'Icon': ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: Text(label),
      ),
      'Disabled': ElevatedButton(
        onPressed: null,
        child: Text(label),
      ),
      'Icon Disabled': ElevatedButton.icon(
        onPressed: null,
        icon: const Icon(Icons.add),
        label: Text(label),
      ),
    },
    'TextButton': {
      'Enabled': TextButton(
        onPressed: () {},
        child: Text(label),
      ),
      'Enabled Icon': TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: Text(label),
      ),
      'Disabled': TextButton(
        onPressed: null,
        child: Text(label),
      ),
      'Disabled Icon': TextButton.icon(
        onPressed: null,
        icon: const Icon(Icons.add),
        label: Text(label),
      ),
    },
    'OutlinedButton': {
      'Enabled': OutlinedButton(
        onPressed: () {},
        child: Text(label),
      ),
      'Enabled Icon': OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: Text(label),
      ),
      'Disabled': OutlinedButton(
        onPressed: null,
        child: Text(label),
      ),
      'Disabled Icon': OutlinedButton.icon(
        onPressed: null,
        icon: const Icon(Icons.add),
        label: Text(label),
      ),
    },
    'IconButton': {
      'Enabled': IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {},
      ),
      'Disabled': const IconButton(
        icon: Icon(Icons.add),
        onPressed: null,
      ),
    },
    'FloatingActionButton': {
      'Enabled': FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      'Disabled': const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
      'Enabled Small': FloatingActionButton.small(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      'Disabled Small': const FloatingActionButton.small(
        onPressed: null,
        child: Icon(Icons.add),
      ),
      'Enabled extended': FloatingActionButton.extended(
        onPressed: () {},
        label: Text(label),
        icon: const Icon(Icons.add),
      ),
      'Disabled extended': FloatingActionButton.extended(
        onPressed: null,
        label: Text(label),
        icon: const Icon(Icons.add),
      ),
    },
  };

  return BaseComponentList(
    components: buttons,
  );
}

@widgetbook.UseCase(name: 'TextStyles', type: BaseComponents)
Widget textStylesBaseComponents(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;

  final styles = {
    'displayLarge': textTheme.displayLarge,
    'displayMedium': textTheme.displayMedium,
    'displaySmall': textTheme.displaySmall,
    'titleLarge': textTheme.titleLarge,
    'titleMedium': textTheme.titleMedium,
    'titleSmall': textTheme.titleSmall,
    'bodyLarge': textTheme.bodyLarge,
    'bodyMedium': textTheme.bodyMedium,
    'bodySmall': textTheme.bodySmall,
    'labelLarge': textTheme.labelLarge,
    'labelMedium': textTheme.labelMedium,
    'labelSmall': textTheme.labelSmall,
  }.map<String, Map<String, Widget>>(
    (key, value) => MapEntry(key, {
      '${value?.fontFamily};${value?.fontSize};${value?.fontWeight}': Text(
        context.knobs
                .stringOrNull(label: 'Text', initialValue: 'Custom Text') ??
            key,
        style: value,
      ),
    }),
  );
  return BaseComponentList(components: styles);
}

@widgetbook.UseCase(name: 'Controls', type: BaseComponents)
Widget controlsBaseComponents(BuildContext context) {
  final controls = {
    'Checkbox': {
      'Interactive': FormField<bool>(
        initialValue: false,
        builder: (formState) {
          return Checkbox(
            value: formState.value,
            onChanged: formState.didChange,
          );
        },
      ),
      'Checked, Disabled': const Checkbox(value: true, onChanged: null),
      'UnChecked, Disabled': const Checkbox(value: false, onChanged: null),
    },
    'Switch': {
      'Interactive': FormField<bool>(
        initialValue: false,
        builder: (formState) {
          return Switch(
            value: formState.value!,
            onChanged: formState.didChange,
          );
        },
      ),
      'On, Disabled': const Switch(value: true, onChanged: null),
      'Off, Disabled': const Switch(value: false, onChanged: null),
    },
    'RadioGroup': {
      'Interactive': FormField<int>(
        builder: (formState) {
          return Column(
            children: [
              TextButton(
                onPressed: formState.reset,
                child: const Text('Reset'),
              ),
              ...List.generate(
                3,
                (index) => Radio<int>(
                  value: index,
                  groupValue: formState.value,
                  onChanged: formState.didChange,
                ),
              ),
            ],
          );
        },
      ),
      'Disabled': Column(
        children: List.generate(
          3,
          (index) => Radio<int>(
            value: index,
            groupValue: 0,
            onChanged: null,
          ),
        ),
      ),
    },
  };

  return BaseComponentList(components: controls);
}

@widgetbook.UseCase(name: 'Indicators', type: BaseComponents)
Widget indicatorsBaseComponents(BuildContext context) {
  final value = context.knobs.double
      .slider(label: 'Value', min: 0, max: 1, initialValue: 0.5);

  final indicators = {
    'Circular': {
      'Determinate': CircularProgressIndicator(
        value: value,
      ),
      'Indeterminate': const CircularProgressIndicator(),
      'Determinate Adaptive': CircularProgressIndicator.adaptive(
        value: value,
      ),
      'Indeterminate Adaptive': const CircularProgressIndicator.adaptive(),
    },
    'Linear': {
      'Determinate': LinearProgressIndicator(
        value: value,
      ),
      'Indeterminate': const LinearProgressIndicator(),
    },
  };

  return BaseComponentList(components: indicators);
}

@widgetbook.UseCase(name: 'Chips', type: BaseComponents)
Widget chipsBaseComponents(BuildContext context) {
  final label = context.knobs.string(label: 'Label', initialValue: 'Label');

  final chips = {
    'Chip': {
      'Chip': Chip(
        label: Text(label),
      ),
    },
    'InputChip': {
      'Input Chip': InputChip(
        label: Text(label),
      ),
    },
    'ChoiceChip': {
      'Interactive': FormField<bool>(
        initialValue: true,
        builder: (formState) => ChoiceChip(
          label: Text(label),
          selected: formState.value!,
          onSelected: formState.didChange,
        ),
      ),
      'Selected, Disabled': ChoiceChip(
        label: Text(label),
        selected: true,
      ),
      'Unselected Disabled': ChoiceChip(
        label: Text(label),
        selected: false,
      ),
    },
    'FilterChip': {
      'Interactive': FormField<bool>(
        initialValue: true,
        builder: (formState) => FilterChip(
          label: Text(label),
          selected: formState.value!,
          onSelected: formState.didChange,
        ),
      ),
      'Selected, Disabled': FilterChip(
        label: Text(label),
        selected: true,
        onSelected: null,
      ),
      'Unselected Disabled': FilterChip(
        label: Text(label),
        selected: false,
        onSelected: null,
      ),
    },
    'ActionChip': {
      'Enabled': ActionChip(
        label: Text(label),
        onPressed: () {},
      ),
      'Disabled': ActionChip(
        label: Text(label),
      ),
    },
  };

  return BaseComponentList(components: chips);
}

@widgetbook.UseCase(name: 'AlertDialog', type: BaseComponents)
Widget alertDialogBaseComponents(BuildContext context) {
  final title = context.knobs.string(label: 'Title', initialValue: 'Title');
  final body = context.knobs.stringOrNull(label: 'Body', initialValue: 'Body');
  return Row(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Flexible(flex: 1, child: SizedBox()),
      Flexible(
        flex: 2,
        child: Center(
          child: AlertDialog(
            title: Text(title),
            content: body != null ? Text(body) : null,
            actions: [
              TextButton(onPressed: () {}, child: const Text('OK')),
            ],
          ),
        ),
      ),
      const Flexible(flex: 1, child: SizedBox()),
    ],
  );
}

@widgetbook.UseCase(name: 'BottomNavigationBar', type: BaseComponents)
Widget bottombarBaseComponents(BuildContext context) {
  final items = context.knobs.double
      .slider(label: 'Items', min: 2, max: 5, divisions: 3, initialValue: 3)
      .toInt();
  final type = context.knobs.listOrNull<BottomNavigationBarType>(
    label: 'Type',
    options: [null, ...BottomNavigationBarType.values],
    labelBuilder: (type) => type?.name ?? 'null',
  );

  return Row(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Flexible(flex: 1, child: SizedBox()),
      Flexible(
        flex: 2,
        child: Center(
          child: FormField<int>(
            initialValue: 0,
            builder: (formData) {
              return BottomNavigationBar(
                currentIndex: formData.value!,
                onTap: formData.didChange,
                type: type,
                items: List.generate(
                  items,
                  (index) => BottomNavigationBarItem(
                    icon: const Icon(Icons.account_circle),
                    label: 'Item $index',
                  ),
                ),
              );
            },
          ),
        ),
      ),
      const Flexible(flex: 1, child: SizedBox()),
    ],
  );
}

@widgetbook.UseCase(name: 'TextField', type: BaseComponents)
Widget textFieldBaseComponents(BuildContext context) {
  final hint = context.knobs.stringOrNull(label: 'Hint', initialValue: 'Hint');
  final label =
      context.knobs.stringOrNull(label: 'Label', initialValue: 'Label');
  final helper =
      context.knobs.stringOrNull(label: 'Helper', initialValue: 'Helper');
  final error = context.knobs.stringOrNull(
    label: 'Error',
  );
  return Material(
    color: Colors.transparent,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(flex: 1, child: SizedBox()),
            Flexible(
              flex: 2,
              child: TextField(
                decoration: InputDecoration(
                  hintText: hint,
                  labelText: label,
                  helperText: helper,
                  errorText: error,
                ),
              ),
            ),
            const Flexible(flex: 1, child: SizedBox()),
          ],
        ),
        TextButton(
          onPressed: FocusNode().requestFocus,
          child: const Text('Clear Focus'),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'ListTile', type: BaseComponents)
Widget listTileBaseComponents(BuildContext context) {
  final title = context.knobs.string(label: 'Title', initialValue: 'Title');
  final subTitle =
      context.knobs.stringOrNull(label: 'Subtitle', initialValue: 'Subtitle');

  final leading = context.knobs.boolean(label: 'Leading');
  final trailing = context.knobs.boolean(label: 'Trailing');

  final tiles = {
    'ListTile': {
      'Clickable': ListTile(
        title: Text(title),
        subtitle: subTitle != null ? Text(subTitle) : null,
        leading: leading ? const Icon(Icons.account_circle) : null,
        trailing: trailing ? const Icon(Icons.chevron_right) : null,
        onTap: () {},
      ),
      'Unclickable': ListTile(
        title: Text(title),
        subtitle: subTitle != null ? Text(subTitle) : null,
        leading: leading ? const Icon(Icons.account_circle) : null,
        trailing: trailing ? const Icon(Icons.chevron_right) : null,
      ),
    },
  };

  return BaseComponentList(components: tiles);
}

@widgetbook.UseCase(name: 'Card', type: BaseComponents)
Widget cardBaseComponents(BuildContext context) {
  return const Row(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Flexible(flex: 1, child: SizedBox()),
      Flexible(
        flex: 2,
        child: Center(
          child: Card(
            child: AspectRatio(aspectRatio: 3 / 2),
          ),
        ),
      ),
      Flexible(flex: 1, child: SizedBox()),
    ],
  );
}
