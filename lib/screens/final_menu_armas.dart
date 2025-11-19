import 'package:flutter/material.dart';

class FinalMenuArmas extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback onShowCoinsStore;

  const FinalMenuArmas({
    super.key,
    required this.onClose,
    required this.onShowCoinsStore,
  });

  @override
  State<FinalMenuArmas> createState() => _FinalMenuArmasState();
}

class _FinalMenuArmasState extends State<FinalMenuArmas> {
  int selectedWeaponIndex = 0;

  final List<Map<String, dynamic>> weapons = [
    {
      'name': 'PISTOLA CLASSIC',
      'image': 'assets/images/pistola.png',
      'damage': 'Medio',
      'damageValue': 800,
      'fireRate': 'Media',
      'fireRateValue': 1200,
      'precision': 'Media-Alta',
      'magazine': '12 balas',
      'description': 'Una pistola confiable para combate cercano.',
      'price': 500,
    },
    {
      'name': 'ESCOPETA COMBATE',
      'image': 'assets/images/escopeta.png',
      'damage': 'Alto',
      'damageValue': 1200,
      'fireRate': 'Baja',
      'fireRateValue': 800,
      'precision': 'Baja',
      'magazine': '8 balas',
      'description': 'Devastadora a corta distancia.',
      'price': 1200,
    },
    {
      'name': 'RIFLE ASALTO',
      'image': 'assets/images/rifle.png',
      'damage': 'Alto',
      'damageValue': 1500,
      'fireRate': 'Alta',
      'fireRateValue': 1800,
      'precision': 'Media-Alta',
      'magazine': '30 balas',
      'description': 'Un fiable de rifle de medio alcance.',
      'price': 2500,
    },
    {
      'name': 'DOOMER SHOTGNN',
      'image': 'assets/images/doomer.png',
      'damage': 'Muy Alto',
      'damageValue': 1800,
      'fireRate': 'Baja',
      'fireRateValue': 600,
      'precision': 'Media',
      'magazine': '6 balas',
      'description': 'Poder destructivo máximo.',
      'price': 3500,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final selectedWeapon = weapons[selectedWeaponIndex];

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
              // Header with Points and Back Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildBackButton(),
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
                          // Title and Coins Button
                          _buildHeader(),
                          const SizedBox(height: 16),
                          
                          // Tabs
                          _buildTabs(),
                          const SizedBox(height: 16),
                          
                          // Content Area
                          Expanded(
                            child: Row(
                              children: [
                                // Weapons List
                                Expanded(
                                  flex: 2,
                                  child: _buildWeaponsList(),
                                ),
                                const SizedBox(width: 16),
                                
                                // Weapon Details
                                Expanded(
                                  flex: 3,
                                  child: _buildWeaponDetails(selectedWeapon),
                                ),
                              ],
                            ),
                          ),
                          
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

  Widget _buildBackButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF6B4423),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF8B6F47), width: 2),
      ),
      child: InkWell(
        onTap: widget.onClose,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'TIENDA',
          style: TextStyle(
            color: Color(0xFFE8D4A0),
            fontSize: 48,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.black,
                offset: Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: widget.onShowCoinsStore,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF6B4423),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF8B6F47), width: 2),
            ),
            child: Row(
              children: [
                Icon(Icons.monetization_on, color: Colors.amber, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'MONEDAS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Row(
      children: [
        _buildTab('ARMAS', true),
        const SizedBox(width: 8),
        _buildTab('MONEDAS', false),
      ],
    );
  }

  Widget _buildTab(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF4A7C59) : const Color(0xFF6B4423),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isActive ? const Color(0xFF5FA777) : const Color(0xFF8B6F47),
          width: 2,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildWeaponsList() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF4A3829).withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF6B4423), width: 2),
      ),
      child: ListView.builder(
        itemCount: weapons.length,
        itemBuilder: (context, index) {
          final weapon = weapons[index];
          final isSelected = index == selectedWeaponIndex;
          
          return InkWell(
            onTap: () {
              setState(() {
                selectedWeaponIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected 
                    ? const Color(0xFF4A7C59) 
                    : const Color(0xFF6B4423),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected 
                      ? const Color(0xFF5FA777) 
                      : const Color(0xFF8B6F47),
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      Icons.sports_esports,
                      color: Colors.white70,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      weapon['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWeaponDetails(Map<String, dynamic> weapon) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF4A3829).withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF6B4423), width: 2),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Weapon Image
          Center(
            child: Container(
              width: 200,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.sports_esports,
                color: Colors.amber,
                size: 80,
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Weapon Name
          Center(
            child: Text(
              weapon['name'],
              style: const TextStyle(
                color: Color(0xFFE8D4A0),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Stats
          _buildStat('DAÑO: ${weapon['damage']}', weapon['damageValue']),
          _buildStat('CADENCIA: ${weapon['fireRate']}', weapon['fireRateValue']),
          _buildStat('PRECISIÓN: ${weapon['precision']}', null),
          _buildStat('CARGADOR: ${weapon['magazine']}', null),
          const SizedBox(height: 12),
          
          // Description
          Text(
            'DESCRIPCIÓN: ${weapon['description']}',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
          
          const Spacer(),
          
          // Buy Button
          Center(
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
                'COMPRAR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, int? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (value != null)
            Text(
              value.toString(),
              style: const TextStyle(
                color: Color(0xFFE8D4A0),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildReturnButton() {
    return Center(
      child: ElevatedButton(
        onPressed: widget.onClose,
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
