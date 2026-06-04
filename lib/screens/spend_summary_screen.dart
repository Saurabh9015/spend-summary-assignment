import 'package:flutter/material.dart';

import '../core/constants/app_layout.dart';
import '../data/dummy_data.dart';
import '../widgets/add_transaction_sheet.dart';
import '../widgets/category_item.dart';
import '../widgets/spend_header_card.dart';
import '../widgets/spending_insights_card.dart';
import '../widgets/staggered_fade_in.dart';
import '../widgets/transaction_tile.dart';

class SpendSummaryScreen extends StatefulWidget {
  const SpendSummaryScreen({
    super.key,
    required this.themeMode,
    required this.onToggleTheme,
  });

  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  @override
  State<SpendSummaryScreen> createState() => _SpendSummaryScreenState();
}

class _SpendSummaryScreenState extends State<SpendSummaryScreen> {
  int _animationGeneration = 0;
  bool _isRefreshing = false;

  Future<void> _onRefresh() async {
    if (_isRefreshing) return;
    setState(() => _isRefreshing = true);
    await Future<void>.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() {
      _isRefreshing = false;
      _animationGeneration++;
    });
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Spend summary updated')),
      );
  }

  void _onSearchTap() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Search — demo only')),
      );
  }

  IconData _themeToggleIcon(BuildContext context) {
    return switch (widget.themeMode) {
      ThemeMode.dark => Icons.dark_mode_rounded,
      ThemeMode.light => Icons.light_mode_rounded,
      ThemeMode.system => Icons.brightness_auto_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final transactions = DummyData.recentTransactions;
    final animationKey = ValueKey<int>(_animationGeneration);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Spend Summary'),
        actions: [
          IconButton(
            onPressed: _onSearchTap,
            tooltip: 'Search',
            icon: const Icon(Icons.search_rounded),
          ),
          IconButton(
            onPressed: widget.onToggleTheme,
            tooltip: 'Toggle theme',
            icon: Icon(_themeToggleIcon(context)),
          ),
          const SizedBox(width: 4),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => AddTransactionSheet.show(context),
        tooltip: 'Add transaction',
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add'),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          edgeOffset: 8,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppLayout.horizontalPadding,
                  16,
                  AppLayout.horizontalPadding,
                  0,
                ),
                sliver: SliverToBoxAdapter(
                  child: SpendHeaderCard.fromSummary(
                    key: animationKey,
                    summary: DummyData.summary,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppLayout.horizontalPadding,
                  AppLayout.sectionSpacing,
                  AppLayout.horizontalPadding,
                  0,
                ),
                sliver: SliverToBoxAdapter(
                  child: StaggeredFadeIn(
                    key: ValueKey('insights_$_animationGeneration'),
                    index: 1,
                    child: const SpendingInsightsCard(),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppLayout.horizontalPadding,
                  AppLayout.sectionSpacing,
                  AppLayout.horizontalPadding,
                  8,
                ),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Categories',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: 12),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: AppLayout.categoryListHeight,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      clipBehavior: Clip.none,
                      padding: const EdgeInsets.only(
                        left: AppLayout.horizontalPadding,
                        right: AppLayout.horizontalPadding,
                      ),
                      itemCount: DummyData.categories.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        width: AppLayout.categorySeparatorWidth,
                      ),
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: AppLayout.categoryItemWidth,
                          child: StaggeredFadeIn(
                            key: ValueKey(
                              'cat_${index}_$_animationGeneration',
                            ),
                            index: index + 2,
                            child: CategoryItem(
                              category: DummyData.categories[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppLayout.horizontalPadding,
                  AppLayout.sectionSpacing,
                  AppLayout.horizontalPadding,
                  8,
                ),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Recent Transactions',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppLayout.horizontalPadding,
                  0,
                  AppLayout.horizontalPadding,
                  108,
                ),
                sliver: SliverToBoxAdapter(
                  child: StaggeredFadeIn(
                    key: ValueKey('tx_card_$_animationGeneration'),
                    index: 3,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        child: Column(
                          children: [
                            for (var i = 0; i < transactions.length; i++) ...[
                              StaggeredFadeIn(
                                key: ValueKey(
                                  'tx_${transactions[i].id}_$_animationGeneration',
                                ),
                                index: i + 4,
                                child: TransactionTile(
                                  transaction: transactions[i],
                                ),
                              ),
                              if (i < transactions.length - 1)
                                Padding(
                                  padding: const EdgeInsets.only(left: 62),
                                  child: Divider(
                                    height: 1,
                                    thickness: 1,
                                  ),
                                ),
                            ],
                          ],
                        ),
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
}
