import 'package:flutter/material.dart';

class FloorPlanScreen extends StatelessWidget {
  const FloorPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'FLOOR PLAN',
          style: TextStyle(
            color: Color(0xFF1B3B4B),
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF1B3B4B)),
      ),
      body: InteractiveViewer(
        minScale: 1.0,
        maxScale: 5.0,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FittedBox(
              fit: BoxFit.contain,
              child: const RotatedBox(
                quarterTurns: 1,
                child: FloorPlanCanvas(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FloorPlanCanvas extends StatelessWidget {
  const FloorPlanCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    const Color hallFill = Color(0xFFDEEAF6);
    const Color borderDark = Color(0xFF1F4E79);
    const Color stallYellow = Color(0xFFFFFF00);
    const Color receptionGreen = Color(0xFF92D050);

    return Container(
      width: 800,
      height: 600,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black87, width: 4),
      ),
      child: Stack(
        children: [
          // Connecting Lines at bottom
          Positioned(
            left: 50,
            bottom: 60,
            child: Container(width: 1, height: 40, color: borderDark),
          ),
          Positioned(
            right: 50,
            bottom: 60,
            child: Container(width: 1, height: 40, color: borderDark),
          ),
          Positioned(
            left: 50,
            bottom: 60,
            child: Container(width: 320, height: 1, color: borderDark),
          ),
          Positioned(
            right: 50,
            bottom: 60,
            child: Container(width: 320, height: 1, color: borderDark),
          ),
          
          // Entrance Icon
          Positioned(
            bottom: 50,
            left: 370,
            child: SizedBox(
              width: 60,
              height: 30,
              child: CustomPaint(
                painter: EntranceDoorPainter(color: borderDark),
              ),
            ),
          ),
          
          // Entrance Text
          const Positioned(
            bottom: 10,
            left: 320,
            right: 320,
            child: Text(
              'Minerva Grand\nEntrance',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),

          // HALL 1
          Positioned(
            left: 50,
            top: 50,
            width: 300,
            height: 450,
            child: Container(
              decoration: BoxDecoration(
                color: hallFill,
                border: Border.all(color: borderDark, width: 2),
              ),
              alignment: Alignment.center,
              child: const Text(
                'HALL-1',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          
          // HALL 1 top rectangle
          Positioned(
            left: 140,
            top: 50,
            width: 120,
            height: 50,
            child: Container(
              decoration: BoxDecoration(
                color: hallFill,
                border: Border.all(color: borderDark, width: 5),
              ),
            ),
          ),
          
          // HALL 1 Circles
          _buildCircle(40, 40),
          _buildCircle(190, 40),
          _buildCircle(340, 40),
          _buildCircle(40, 265),
          _buildCircle(40, 490),
          _buildCircle(190, 490),
          _buildCircle(340, 490),
          
          // HALL 1 Bottom Door
          Positioned(
            left: 340,
            bottom: 110,
            width: 20,
            height: 50,
            child: Container(
              decoration: BoxDecoration(
                color: hallFill,
                border: Border.all(color: borderDark, width: 3),
              ),
            ),
          ),

          // HALL 2
          Positioned(
            left: 450,
            top: 50,
            width: 300,
            height: 450,
            child: Container(
              decoration: BoxDecoration(
                color: hallFill,
                border: Border.all(color: borderDark, width: 2),
              ),
              alignment: Alignment.center,
              child: const Text(
                'HALL-2',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          
          // HALL 2 Bottom Door
          Positioned(
            left: 440,
            bottom: 110,
            width: 20,
            height: 50,
            child: Container(
              decoration: BoxDecoration(
                color: hallFill,
                border: Border.all(color: borderDark, width: 3),
              ),
            ),
          ),

          // Reception
          Positioned(
            left: 410,
            top: 200,
            width: 30,
            height: 150,
            child: Container(
              decoration: BoxDecoration(
                color: receptionGreen,
                border: Border.all(color: borderDark, width: 2),
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: RotatedBox(
                quarterTurns: 3,
                child: const Text(
                  'Reception',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),

          // Stalls 1 to 6 (Left of HALL 2)
          ...List.generate(6, (index) {
            int stallNum = 6 - index;
            return Positioned(
              left: 435,
              top: 100 + (index * 45).toDouble(),
              width: 35,
              height: 35,
              child: _buildStall(stallNum.toString(), stallYellow, borderDark),
            );
          }),

          // Stalls 7 to 13 (Right of HALL 2)
          ...List.generate(7, (index) {
            int stallNum = 7 + index;
            return Positioned(
              right: 50,
              top: 100 + (index * 45).toDouble(),
              width: 35,
              height: 35,
              child: _buildStall(stallNum.toString(), stallYellow, borderDark),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCircle(double x, double y) {
    return Positioned(
      left: x,
      top: y,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF7F7F7F), width: 3),
        ),
      ),
    );
  }

  Widget _buildStall(String text, Color color, Color borderColor) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: RotatedBox(
        quarterTurns: 3,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

class EntranceDoorPainter extends CustomPainter {
  final Color color;
  EntranceDoorPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Left base
    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width * 0.3, size.height),
      paint,
    );
    // Left door open
    canvas.drawLine(
      Offset(size.width * 0.3, size.height),
      Offset(size.width * 0.45, 0),
      paint,
    );

    // Right base
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width * 0.7, size.height),
      paint,
    );
    // Right door open
    canvas.drawLine(
      Offset(size.width * 0.7, size.height),
      Offset(size.width * 0.55, 0),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
