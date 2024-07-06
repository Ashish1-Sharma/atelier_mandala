import 'package:atelier_admin/features/payments/presentation/widgets/custom_payment_card.dart';
import 'package:flutter/cupertino.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 5,
        runSpacing: 10,
        children: List.generate(5, (index) {
          return CustomPaymentCard();
        },),
      ),
    );
  }
}
