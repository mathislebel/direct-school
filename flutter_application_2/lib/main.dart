import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LetterScreen(),
    );
  }
}

class LetterScreen extends StatefulWidget {
  @override
  _LetterScreenState createState() => _LetterScreenState();
}

class _LetterScreenState extends State<LetterScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;  // Correction : utilisation de 'late' pour initialisation tardive
  late Animation<Offset> _offsetAnimation; // Correction : utilisation de 'late' pour initialisation tardive

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lettre d\'amour'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset('assets/envelope.png', width: 300),
            SlideTransition(
              position: _offsetAnimation,
              child: Container(
                width: 250,
                height: 350,
                color: Colors.white,
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Je t\'aime mon amour même si tu me prends la tête et que tu es souvent aigrie. '
                      'Je t\'aime et j\'aime pas quand on se prend la tête. Tu es la meilleure des meufs que j\'ai jamais eue. '
                      'Merci d\'accepter de partager ma vie. Donc accepterais-tu de faire la méthode KISS (calin ++) avec moi ? Je t\'aime.',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                    
                          ElevatedButton(
                            onPressed: () {
                              _showResponse(context, 'Oui');
                            },
                            child: Text('Oui'),
                          ),
                      
                        SizedBox(width: 2),
                      
                         ElevatedButton(
                            onPressed: () {
                              _showResponse(context, 'Non');
                            },
                            child: Text('Non'),
                          ),
                          
                    
                        SizedBox(width: 1),
                      
                           ElevatedButton(
                            onPressed: () {
                              _showResponse(context, 'Je sais pas');
                            },
                            child: Text('JSP'),
                          ),
                      

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showResponse(BuildContext context, String response) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Vous avez répondu: $response'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
