import 'package:flutter/material.dart';

class FinalMenuMonedas extends StatelessWidget {
  final VoidCallback onClose;

  const FinalMenuMonedas({
    super.key,
    required this.onClose,
  });

  final List<Map<String, dynamic>> coinPackages = const [
    {
      'name': 'PAQUETE PEQUEÑO',
      'coins': '500 Monedas',
      'price': '\$9 MXN',
    },
    {
      'name': '12,010 MONEDAS',
      'coins': '12,010 Monedas',
      'price': '\$29 MXN',
    },
    {
      'name': '500 MONEDAS',
      'coins': '500 Monedas',
      'price': '\$19 MXN',
    },
    {
      'name': '2,0500 GRANDE',
      'coins': '2,0500 Monedas',
      'price': '\$49 MXN',
    },
    {
      'name': '16,000 MEGA',
      'coins': '16,000 Monedas',
      'price': '\$99 MXN',
    },
    {
      'name': '34,000 MEGA',
      'coins': '34,000 Monedas',
      'price': '\$149 MXN',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      color: Colors.transparent,
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_city.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.7),
              BlendMode.darken,
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with Points
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildPointsDisplay(),
                  ],
                ),
              ),
              
              // Main Store Panel
              Expanded(
                child: Center(
                  child: Container(
                    width: size.width * 0.9,
                    height: size.height * 0.75,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/wood_panel.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          // Title
                          _buildHeader(),
                          const SizedBox(height: 8),
                          
                          // Back Button
                          Align(
                            alignment: Alignment.centerLeft,
                            child: _buildBackButton(),
                          ),
                          const SizedBox(height: 16),
                          
                          // Coin Packages Grid
                          Expanded(
                            child: _buildCoinPackagesGrid(),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Buy Package Button
                          _buildBuyButton(),
                          const SizedBox(height: 16),
                          
                          // Return Button
                          _buildReturnButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPointsDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.monetization_on, color: Colors.amber, size: 24),
          const SizedBox(width: 8),
          const Text(
            'POINTS: 8000',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Text(
      'COMPRAR MONEDAS',
      style: TextStyle(
        color: Color(0xFFE8D4A0),
        fontSize: 42,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(
            color: Colors.black,
            offset: Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF6B4423),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF8B6F47), width: 2),
      ),
      child: InkWell(
        onTap: onClose,
        child: const Text(
          'REGRESAR',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildCoinPackagesGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.5,
      ),
      itemCount: coinPackages.length,
      itemBuilder: (context, index) {
        final package = coinPackages[index];
        return _buildCoinPackageCard(package);
      },
    );
  }

  Widget _buildCoinPackageCard(Map<String, dynamic> package) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF6B4423),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF8B6F47), width: 2),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Coin Icon
          const Icon(
            Icons.monetization_on,
            color: Colors.amber,
            size: 40,
          ),
          const SizedBox(height: 8),
          
          // Package Name
          Text(
            package['name'],
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFE8D4A0),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          
          // Coins Amount
          Text(
            package['coins'],
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          
          // Price
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF4A3829),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              package['price'],
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBuyButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6B4423),
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Color(0xFF8B6F47), width: 2),
          ),
        ),
        child: const Text(
          'COMPRAR PAQUETE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildReturnButton() {
    return Center(
      child: ElevatedButton(
        onPressed: onClose,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6B4423),
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Color(0xFF8B6F47), width: 2),
          ),
        ),
        child: const Text(
          'VOLVER',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
