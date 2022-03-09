import 'package:flutter/material.dart';

class NeumorphismButton extends StatefulWidget {
  const NeumorphismButton({
    Key? key,
    this.height = 40,
    this.width = 40,
    this.onTap,
    this.color =  Colors.white, 
  }) : super(key: key);

  final double? height;
  final double? width;
  final Color? color;
  final GestureTapCallback? onTap;

  @override
  State<NeumorphismButton> createState() => _NeumorphismButtonState();
}

class _NeumorphismButtonState extends State<NeumorphismButton> {
  bool _isElevated = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            
            if ( _isElevated==false && widget.onTap!= null){
              widget.onTap!();
            }
            
            _isElevated = !_isElevated;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 200,
          ),
          height: widget.height,
          width: widget.height,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: _isElevated
                ? [
                    const BoxShadow(
                      color: Colors.grey,
                      offset: Offset(4, 4),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4, -4),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
        ),
      ),
    );
  }
}
