import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AdminSection {
  dashboard,
  about,
  skills,
  education,
  contact,
}

class AdminNavigationState {
  final AdminSection currentSection;
  final bool isSidebarExpanded;

  const AdminNavigationState({
    required this.currentSection,
    this.isSidebarExpanded = true,
  });

  AdminNavigationState copyWith({
    AdminSection? currentSection,
    bool? isSidebarExpanded,
  }) {
    return AdminNavigationState(
      currentSection: currentSection ?? this.currentSection,
      isSidebarExpanded: isSidebarExpanded ?? this.isSidebarExpanded,
    );
  }
}

class AdminNavigationNotifier extends StateNotifier<AdminNavigationState> {
  AdminNavigationNotifier() : super(const AdminNavigationState(
    currentSection: AdminSection.dashboard,
    isSidebarExpanded: true,
  ));

  void navigateToSection(AdminSection section) {
    state = state.copyWith(currentSection: section);
  }

  void toggleSidebar() {
    state = state.copyWith(isSidebarExpanded: !state.isSidebarExpanded);
  }

  void collapseSidebar() {
    state = state.copyWith(isSidebarExpanded: false);
  }

  void expandSidebar() {
    state = state.copyWith(isSidebarExpanded: true);
  }
}

final adminNavigationProvider = StateNotifierProvider<AdminNavigationNotifier, AdminNavigationState>((ref) {
  return AdminNavigationNotifier();
});

final currentAdminSectionProvider = Provider<AdminSection>((ref) {
  return ref.watch(adminNavigationProvider).currentSection;
});

final isSidebarExpandedProvider = Provider<bool>((ref) {
  return ref.watch(adminNavigationProvider).isSidebarExpanded;
});
