part of '../dart_fusion.dart';

class DOption extends StatelessWidget {
  const DOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0 * 0.35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Type',
                style: context.text.bodyMedium?.copyWith(
                  color: context.color.onBackground.withOpacity(0.5),
                  fontSize: 10.0,
                ),
              ),
              Tooltip(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0.0, 1.0),
                        blurRadius: 4.0,
                        color: context.color.primary.withOpacity(0.25),
                      )
                    ],
                    borderRadius: BorderRadius.circular(20.0 * 0.5),
                    border: Border.all(
                        color: context.color.primary.withOpacity(0.15)),
                    color: context.color.background),
                richMessage: TextSpan(
                    children: [
                      const TextSpan(
                          text:
                              "Remember you can't edit the publicity type once you create this workspace.\n\n"),
                      TextSpan(
                          text: '🌎 Public : ',
                          style: context.text.bodySmall
                              ?.copyWith(color: context.color.onBackground)),
                      const TextSpan(text: 'Only bla bla bla xxxx\n'),
                      TextSpan(
                          text: '🔑 Private : ',
                          style: context.text.bodySmall
                              ?.copyWith(color: context.color.onBackground)),
                      const TextSpan(text: 'Only bla bla bla xxxx')
                    ],
                    style: context.text.bodySmall?.copyWith(
                        color: context.color.onBackground.withOpacity(0.5))),
                child: InkMaterial(
                    onTap: () {},
                    shapeBorder: const CircleBorder(),
                    color: context.color.onBackground.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.question_mark_rounded,
                        color: context.color.background,
                        size: 10.0,
                      ),
                    )),
              )
            ],
          ),
        ),
        Container(
          height: kTextTabBarHeight,
          decoration: BoxDecoration(
              color: context.color.background,
              borderRadius: BorderRadius.circular(20.0 * 0.5),
              border: Border.all(
                color: context.color.primary.withOpacity(0.15),
              )),
          child: DropdownButton(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            value: AppSectionModel.public.id,
            underline: const SizedBox(),
            isExpanded: true,
            items: [
              for (var item in AppPageModel.workspace.sections)
                DropdownMenuItem(
                    value: item.id,
                    child: Text(item.name,
                        style: context.text.bodySmall
                            ?.copyWith(color: context.color.onBackground)))
            ],
            onChanged: (_) {},
            style: context.text.bodyMedium
                ?.copyWith(color: context.color.background),
          ),
        ),
      ],
    );
  }
}
