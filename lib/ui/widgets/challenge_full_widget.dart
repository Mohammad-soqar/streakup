import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChallengeFullWidget extends StatefulWidget {
  final String text;
  final Color color;
  final String type;
  final String emoji;
  final String image;

  const ChallengeFullWidget({
    super.key,
    required this.text,
    required this.color,
    required this.type,
    required this.emoji,
    required this.image,
  });

  @override
  State<ChallengeFullWidget> createState() => _ChallengeFullWidgetState();
}

class _ChallengeFullWidgetState extends State<ChallengeFullWidget> {
  bool isSelected = false;
  double size = 38;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      foregroundDecoration: BoxDecoration(
        border: Border.all(
          color: isSelected
              ? Theme.of(context).colorScheme.onSurface
              : Theme.of(context).colorScheme.onInverseSurface,
          width: isSelected ? 1.5 : 0,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.asset(
              widget.image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface,
                        shape: BoxShape.circle,
                      ),
                      child: SizedBox(
                        width: size,
                        height: size,
                        child: Center(
                          child: Text(
                            widget.emoji,
                            style: TextStyle(
                              fontSize: 20,
                              color: widget.color,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      widget.text,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected = !isSelected;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.inversePrimary
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/Circle_Check.svg',
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.primaryContainer,
                      width: size,
                      height: size,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
