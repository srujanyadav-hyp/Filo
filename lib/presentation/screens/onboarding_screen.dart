// FILO Onboarding Screen
// Per Phase 5 Task 2: 3-screen onboarding flow

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/feature_card.dart';
import '../../data/repositories/onboarding_repository.dart';
import 'home_screen.dart';

/// Onboarding flow with 3 screens
///
/// Screen 1: Welcome + intro
/// Screen 2: Feature highlights
/// Screen 3: Permission request
///
/// Shows only on first run, persists completion to SharedPreferences.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final OnboardingRepository _repository = OnboardingRepository();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  Future<void> _completeOnboarding() async {
    await _repository.completeOnboarding();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
      // Show welcome message
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Welcome! Tap + to add files'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      });
    }
  }

  Future<void> _requestPermission() async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      _completeOnboarding();
    } else if (status.isPermanentlyDenied) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Storage permission is required. Please enable in settings.',
            ),
            action: SnackBarAction(
              label: 'Settings',
              onPressed: () => openAppSettings(),
            ),
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } else {
      // Permission denied but not permanently
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Storage permission is needed to organize your files',
            ),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void _skipToHome() {
    _completeOnboarding();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // On last page, request permission
      _requestPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button (only on pages 0 and 1)
            if (_currentPage < 2)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.paddingMedium),
                  child: TextButton(
                    onPressed: _skipToHome,
                    child: Text(
                      'Skip',
                      style: AppTypography.bodyL.copyWith(
                        color: AppColors.accentTeal500,
                      ),
                    ),
                  ),
                ),
              )
            else
              SizedBox(height: AppSpacing.massive),

            // PageView with 3 pages
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: [
                  _buildWelcomePage(),
                  _buildFeaturesPage(),
                  _buildPermissionsPage(),
                ],
              ),
            ),

            // Page indicators
            _buildPageIndicators(),

            SizedBox(height: AppSpacing.paddingLarge),

            // Next/Grant Permission button (48dp height per spec)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.paddingLarge,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentTeal500,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _currentPage == 2 ? 'Grant Permission' : 'Next',
                    style: AppTypography.bodyL.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // Skip for now button (only on page 3)
            if (_currentPage == 2)
              TextButton(
                onPressed: _skipToHome,
                child: Text(
                  'Skip for now',
                  style: AppTypography.bodyM.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              )
            else
              SizedBox(height: AppSpacing.massive),

            SizedBox(height: AppSpacing.paddingLarge),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomePage() {
    return OnboardingPage(
      illustration: _buildIllustration(
        icon: Icons.folder_special,
        color: AppColors.accentTeal500,
      ),
      title: 'Welcome to FILO',
      subtitle: 'Your intelligent file organizer',
    );
  }

  Widget _buildFeaturesPage() {
    return OnboardingPage(
      illustration: _buildIllustration(
        icon: Icons.auto_awesome,
        color: AppColors.info,
      ),
      title: 'Powerful Features',
      subtitle: 'Organize and find files effortlessly',
      content: Column(
        children: [
          FeatureCard(
            icon: Icons.search,
            title: 'Smart Search',
            description: 'Find files by content, not just names',
            iconColor: AppColors.accentTeal500,
          ),
          SizedBox(height: AppSpacing.paddingMedium),
          FeatureCard(
            icon: Icons.auto_fix_high,
            title: 'Auto-organize',
            description: 'Files organized automatically with AI',
            iconColor: AppColors.info,
          ),
          SizedBox(height: AppSpacing.paddingMedium),
          FeatureCard(
            icon: Icons.rule,
            title: 'Rule Automation',
            description: 'Create custom rules for file management',
            iconColor: AppColors.warning,
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionsPage() {
    return OnboardingPage(
      illustration: _buildIllustration(
        icon: Icons.folder_open,
        color: AppColors.warning,
      ),
      title: 'Allow Storage Access',
      subtitle: 'FILO needs access to organize your files',
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.paddingLarge),
        child: Text(
          'We need permission to read and organize your files. '
          'Your privacy is important—we never upload your data.',
          style: AppTypography.bodyM.copyWith(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildIllustration({required IconData icon, required Color color}) {
    return Container(
      width: 224,
      height: 224,
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        shape: BoxShape.circle,
      ),
      child: Center(child: Icon(icon, size: 120, color: color)),
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == _currentPage
                ? AppColors.accentTeal500
                : AppColors.textSecondary.withAlpha(76),
          ),
        ),
      ),
    );
  }
}
