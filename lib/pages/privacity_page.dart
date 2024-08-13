import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_leitura/pages/initial_home.dart'; // Ajuste o caminho conforme necessário
import 'package:app_leitura/pages/initial_page.dart'; // Ajuste o caminho conforme necessário

class PrivacityPage extends StatefulWidget {
  final String nameUser;

  const PrivacityPage({
    super.key,
    required this.nameUser,
  });

  @override
  _PrivacityPageState createState() => _PrivacityPageState();
}

class _PrivacityPageState extends State<PrivacityPage> {
  bool _buttonsEnabled = true;
  bool _showMessage = false;

  @override
  void initState() {
    super.initState();
  }

  void _onAccept() {
    setState(() {
      _buttonsEnabled = false;
      _showMessage = false;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const InitialHome(nameUser: '')),
    );
  }

  void _onReject() {
    setState(() {
      _buttonsEnabled = false;
      _showMessage = true;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const InitialPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Política de Privacidade'),
        backgroundColor: Colors.grey[300],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AVISO DE PRIVACIDADE DA VIVER EDITORA',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Temos a missão de idealizar, desenvolver, produzir recursos e soluções criativas para alunos, educadores, família, e comunidade com foco no autoconhecimento, motivação e relacionamentos para que o indivíduo se torne autor de seu próprio viver.',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Divisamos ser uma editora com diferencial mercadológico que responda às demandas da sociedade do novo milênio onde a relevância, qualidade, inovação sejam marcas visíveis nascidas do pensamento crítico e da autonomia intelectual.',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Valorizamos a ética, o valor humano, o autoconhecimento, a criatividade e a felicidade.',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'DEFINIÇÕES IMPORTANTES DA LGPD',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Dado pessoal: informação relacionada a pessoa natural identificada ou identificável;\n'
                      '• Dado anonimizado: dado relativo a titular que não possa ser identificado, considerando a utilização de meios técnicos razoáveis e disponíveis na ocasião de seu tratamento;\n'
                      '• Titular: pessoa natural a quem se referem os dados pessoais que são objeto de tratamento;\n'
                      '• Controlador: pessoa natural ou jurídica, de direito público ou privado, a quem competem as decisões referentes ao tratamento de dados pessoais;\n'
                      '• Operador: pessoa natural ou jurídica, de direito público ou privado, que realiza o tratamento de dados pessoais em nome do controlador;\n'
                      '• Encarregado: pessoa indicada pelo controlador e operador para atuar como canal de comunicação entre o controlador, os titulares dos dados e a Autoridade Nacional de Proteção de Dados (ANPD);\n'
                      '• Agentes de tratamento: o controlador e o operador;\n'
                      '• Tratamento: toda operação realizada com dados pessoais, como as que se referem a coleta, produção, recepção, classificação, utilização, acesso, reprodução, transmissão, distribuição, processamento, arquivamento, armazenamento, eliminação, avaliação ou controle da informação, modificação, comunicação, transferência, difusão ou extração;\n'
                      '• ANPD: Autoridade Nacional de Proteção de Dados, órgão da administração pública responsável por zelar, implementar e fiscalizar o cumprimento desta Lei em todo o território nacional.',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'OS PRINCÍPIOS DA LGPD',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'O artigo 6.º da LGPD apresenta os seguintes princípios, os quais observamos no tratamento dos seus dados pessoais:\n'
                      '• Boa-fé: observância ética e legal;\n'
                      '• Finalidade: propósitos legítimos, específicos e explícitos;\n'
                      '• Adequação: compatibilidade do tratamento com as finalidades;\n'
                      '• Necessidade: limitação ao mínimo necessário;\n'
                      '• Livre acesso: acesso do titular aos seus dados pessoais enquanto estiver conosco;\n'
                      '• Qualidade dos dados: dados exatos, corretos e com possibilidade de correção e/ou atualização;\n'
                      '• Transparência: compromisso de prestação de informações claras, precisas e facilitadas aos titulares dos dados, relativamente aos seus dados pessoais;\n'
                      '• Segurança: utilização de medidas técnicas e administrativas para a proteção dos dados pessoais que tratamos;\n'
                      '• Prevenção: adoção de medidas para prevenir danos em virtude do tratamento de dados pessoais;\n'
                      '• Não discriminação: somos contrários a qualquer tipo de discriminação, condutas ilícitas/abusivas;\n'
                      '• Responsabilização e prestação de contas: capacidade de demonstração, comprovação e eficácia na observância das normas de proteção de dados pessoais.',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Na Viver Editora observamos e respeitamos outros princípios e garantias legais, ainda que não explicitadas acima, bem como poderemos adotar outros princípios que se mostrem necessários à manutenção do nosso posicionamento administrativo e compromisso ético.',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Você é titular dos dados pessoais e informações que iremos coletar e utilizar (tratar). Utilizaremos os dados estritamente necessários, somente para atender às finalidades específicas para as quais forem fornecidos, de acordo com o segmento, ambiente e atividade escolhidos.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            if (_showMessage)
              const SizedBox(height: 15), // Espaço adicional abaixo dos botões
            if (_buttonsEnabled) // Adiciona condição para mostrar os botões somente quando habilitados
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _onAccept,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          255, 6, 48, 81), // Cor de fundo do botão
                    ),
                    child: const Text(
                      'Aceitar',
                      style: TextStyle(color: Colors.white), // Cor do texto
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _onReject,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          255, 6, 48, 81), // Cor de fundo do botão
                    ),
                    child: const Text(
                      'Recusar',
                      style: TextStyle(color: Colors.white), // Cor do texto
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
