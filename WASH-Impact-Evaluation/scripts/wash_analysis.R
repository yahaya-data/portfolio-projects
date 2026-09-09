```R
# ==============================================================================
# WASH PROGRAM IMPACT EVALUATION - VISUALIZATION SCRIPT
# Author: Data Analytics Portfolio
# Standards: WHO/UNICEF Joint Monitoring Programme (JMP) Benchmarks
# ==============================================================================

# 1. Load Required Libraries
library(tidyverse)
library(patchwork)
library(scales)

# 2. Load Dataset
wash_data <- read_csv("data/wash_data.csv")

# ==============================================================================
# COLOR PALETTES SET UP (GLOBAL BRANDING & STRICT CONSISTENCY)
# ==============================================================================
phase_colors      <- c("Baseline" = "#D62728", "Endline" = "#2CA02C")
safety_colors     <- c("Unimproved" = "#D62728", "Improved" = "#1F77B4")
target_colors     <- c(">15 Mins" = "#FF7F0E", "<=15 Mins (Target)" = "#2CA02C")
hygiene_colors    <- c("No Facility" = "#D62728", "Water Only" = "#FF7F0E", "Soap & Water" = "#2CA02C")
sanitation_colors <- c("Open Defecation" = "#D62728", "Pit Latrine" = "#1F77B4", "Ventilated Improved Pit" = "#08519C")
community_colors  <- c("Village A" = "#7F7F7F", "Village B" = "#17BECF", "Village C" = "#9467BD")

# ==============================================================================
# THEME SET UP & LAYOUT MARGINS
# ==============================================================================
theme_portfolio <- function() {
  theme_minimal(base_size = 12) +
    theme(
      plot.title = element_text(face = "bold", size = 13, color = "#2c3e50", margin = margin(t = 5, b = 4)),
      plot.subtitle = element_text(size = 10, color = "#7f8c8d", margin = margin(b = 10)),
      axis.title = element_text(face = "bold", size = 10, color = "#34495e"),
      axis.text = element_text(size = 9, color = "#2c3e50"),
      legend.position = "top",
      legend.title = element_blank(),
      panel.grid.minor = element_blank(),
      panel.grid.major.x = element_blank(),
      plot.margin = margin(t = 15, r = 15, b = 15, l = 15, unit = "pt")
    )
}

# ==============================================================================
# SECTION 1: PROGRAMME EVALUATION (BASELINE VS. ENDLINE)
# ==============================================================================

# 1.1 Water Safety Shift
p1_1 <- wash_data %>%
  group_by(Phase, Water_Safety_Flag) %>%
  summarise(n = n(), .groups = "drop") %>%
  group_by(Phase) %>%
  mutate(pct = n / sum(n)) %>%
  ggplot(aes(x = Phase, y = pct, fill = Water_Safety_Flag)) +
  geom_bar(stat = "identity", position = "fill", width = 0.5) +
  scale_y_continuous(labels = percent_format()) +
  scale_fill_manual(values = safety_colors) +
  labs(
    title = "100% Transition to Improved Water Access Achieved Across Target Communities",
    subtitle = "Shift in household primary water source safety (Baseline vs. Endline)",
    x = "Program Phase", y = "Household Proportion"
  ) +
  theme_portfolio()

# 1.2 Fetch Time Target Attainment
p1_2 <- wash_data %>%
  group_by(Phase, Fetch_Time_Target_Flag) %>%
  summarise(n = n(), .groups = "drop") %>%
  group_by(Phase) %>%
  mutate(pct = n / sum(n)) %>%
  ggplot(aes(x = Phase, y = pct, fill = Fetch_Time_Target_Flag)) +
  geom_bar(stat = "identity", position = "fill", width = 0.5) +
  scale_y_continuous(labels = percent_format()) +
  scale_fill_manual(values = target_colors) +
  labs(
    title = "76.8% of Households Reached Target <=15 Minute Water Collection Time",
    subtitle = "Proportion of households meeting the international one-way water fetch time threshold",
    x = "Program Phase", y = "Household Proportion"
  ) +
  theme_portfolio()

# 1.3 Handwashing Facility Infrastructure Growth
p1_3 <- wash_data %>%
  mutate(Handwashing_Facility = factor(Handwashing_Facility, 
                                       levels = c("No Facility", "Water Only", "Soap & Water"))) %>%
  group_by(Phase, Handwashing_Facility) %>%
  summarise(n = n(), .groups = "drop") %>%
  group_by(Phase) %>%
  mutate(pct = n / sum(n)) %>%
  ggplot(aes(x = Phase, y = pct, fill = Handwashing_Facility)) +
  geom_bar(stat = "identity", position = "fill", width = 0.5) +
  scale_y_continuous(labels = percent_format()) +
  scale_fill_manual(values = hygiene_colors) +
  labs(
    title = "Hygiene Practice Adoption Surges: 70% Soap & Water Coverage at Endline",
    subtitle = "Distribution of household handwashing facility stations",
    x = "Program Phase", y = "Household Proportion"
  ) +
  theme_portfolio()

# 1.4 Sanitation Facility Transformation
p1_4 <- wash_data %>%
  group_by(Phase, Sanitation_Type) %>%
  summarise(n = n(), .groups = "drop") %>%
  group_by(Phase) %>%
  mutate(pct = n / sum(n)) %>%
  ggplot(aes(x = Phase, y = pct, fill = Sanitation_Type)) +
  geom_bar(stat = "identity", position = "fill", width = 0.5) +
  scale_y_continuous(labels = percent_format()) +
  scale_fill_manual(values = sanitation_colors) +
  labs(
    title = "Open Defecation Reduced by 80.3% Through Latrine Infrastructure Expansion",
    subtitle = "Household sanitation facility type progression",
    x = "Program Phase", y = "Household Proportion"
  ) +
  theme_portfolio()

# 1.5 Diarrhea Prevalence Drop
p1_5 <- wash_data %>%
  group_by(Phase) %>%
  summarise(prevalence = mean(Diarrhea_Prevalence_Flag), .groups = "drop") %>%
  ggplot(aes(x = Phase, y = prevalence, fill = Phase)) +
  geom_col(width = 0.4, show.legend = FALSE) +
  geom_text(aes(label = percent(prevalence, accuracy = 0.1)), vjust = -0.5, fontface = "bold") +
  scale_y_continuous(labels = percent_format(), limits = c(0, 0.8)) +
  scale_fill_manual(values = phase_colors) +
  labs(
    title = "Child Diarrhea Prevalence Plummets from 68.4% to 16.4%",
    subtitle = "Percentage of households reporting >=1 case among children under 5",
    x = "Program Phase", y = "Diarrhea Prevalence Rate"
  ) +
  theme_portfolio()

# ==============================================================================
# SECTION 2: COMPONENT ASSOCIATIONS TO DISEASE PREVALENCE
# ==============================================================================

# 2.1 Sanitation Type vs. Diarrhea Prevalence (Endline Filtered)
p2_1 <- wash_data %>%
  filter(Phase == "Endline") %>%
  group_by(Sanitation_Type) %>%
  summarise(prevalence = mean(Diarrhea_Prevalence_Flag), .groups = "drop") %>%
  ggplot(aes(x = reorder(Sanitation_Type, prevalence), y = prevalence, fill = Sanitation_Type)) +
  geom_col(width = 0.5, show.legend = FALSE) +
  geom_text(aes(label = percent(prevalence, accuracy = 0.1)), vjust = -0.5, fontface = "bold") +
  scale_y_continuous(labels = percent_format(), limits = c(0, 0.3)) +
  scale_fill_manual(values = sanitation_colors) +
  labs(
    title = "Improved Latrine Use Controls Disease Spread Relative to Open Defecation",
    subtitle = "Endline child diarrhea prevalence by household sanitation facility type",
    x = "Sanitation Facility Type", y = "Diarrhea Prevalence Rate"
  ) +
  theme_portfolio()

# 2.2 Composite WASH Score vs. Diarrhea Prevalence (Baseline vs. Endline)
wash_summary_phased <- wash_data %>%
  mutate(
    Wash_Score = (Water_Safety_Flag == "Improved") + 
      (Fetch_Time_Target_Flag == "<=15 Mins (Target)") + 
      (Handwashing_Facility == "Soap & Water") + 
      (Sanitation_Type %in% c("Pit Latrine", "Ventilated Improved Pit")),
    Score_Group = case_when(
      Wash_Score <= 1 ~ "Low Compliance (0-1)",
      Wash_Score == 2 ~ "Moderate Compliance (2)",
      Wash_Score >= 3 ~ "High Compliance (3-4)"
    )
  ) %>%
  group_by(Phase) %>%
  summarise(
    Avg_Score = mean(Wash_Score),
    Prevalence = mean(Diarrhea_Prevalence_Flag),
    .groups = "drop"
  )

p2_2 <- wash_summary_phased %>%
  ggplot(aes(x = Phase, y = Prevalence, fill = Phase)) +
  geom_col(width = 0.4, show.legend = FALSE) +
  geom_text(
    aes(label = paste0(percent(Prevalence, accuracy = 0.1), "\n(Avg Score: ", round(Avg_Score, 1), "/4)")), 
    vjust = -0.3, 
    fontface = "bold", 
    size = 3.8
  ) +
  scale_y_continuous(labels = percent_format(), limits = c(0, 0.85)) +
  scale_fill_manual(values = phase_colors) +
  labs(
    title = "High Cumulative WASH Adoption Drops Child Diarrhea Rates by 76%",
    subtitle = "Diarrhea prevalence vs. average WASH compliance score (0-4 scale) across program phases",
    x = "Program Phase", 
    y = "Child Diarrhea Prevalence Rate"
  ) +
  theme_portfolio()

# ==============================================================================
# SECTION 3: COMMUNITY-LEVEL IMPACT & GAP COMPARISONS
# ==============================================================================

# 3.1 Endline Performance Comparison Across Communities
endline_gaps <- wash_data %>%
  filter(Phase == "Endline") %>%
  group_by(Community) %>%
  summarise(
    `Diarrhea Prevalence` = mean(Diarrhea_Prevalence_Flag),
    `Open Defecation Rate` = mean(Sanitation_Type == "Open Defecation"),
    `No Handwashing Station` = mean(Handwashing_Facility == "No Facility"),
    `Fetch Target Access (<=15 Mins)` = mean(Fetch_Time_Target_Flag == "<=15 Mins (Target)"),
    .groups = "drop"
  ) %>%
  pivot_longer(-Community, names_to = "Indicator", values_to = "Rate")

p3_1 <- ggplot(endline_gaps, aes(x = Rate, y = reorder(Indicator, Rate), fill = Community)) +
  geom_col(position = position_dodge(width = 0.7), width = 0.6) +
  geom_text(
    aes(label = percent(Rate, accuracy = 0.1)), 
    position = position_dodge(width = 0.7), 
    hjust = -0.2, 
    size = 3.2, 
    fontface = "bold"
  ) +
  scale_x_continuous(labels = percent_format(), limits = c(0, 1.0)) +
  scale_fill_manual(values = community_colors) +
  labs(
    title = "Village C Lags Across Key Sanitation, Proximity & Health Indicators",
    subtitle = "Endline performance comparison across target communities (N=250)",
    x = "Endline Community Proportion",
    y = NULL,
    fill = "Target Community"
  ) +
  theme_portfolio() +
  theme(
    legend.position = "top",
    panel.grid.major.y = element_blank()
  )

# ==============================================================================
# AUTOMATED EXPORT SECTION (SAVES 300 DPI A4-COMPLIANT GRAPHICS TO OUTPUTS/)
# ==============================================================================

if (!dir.exists("outputs")) dir.create("outputs")

ggsave("outputs/chart_1_1_water_safety.png", plot = p1_1, width = 7.0, height = 4.5, dpi = 300)
ggsave("outputs/chart_1_2_fetch_time.png", plot = p1_2, width = 7.0, height = 4.5, dpi = 300)
ggsave("outputs/chart_1_3_hygiene.png", plot = p1_3, width = 7.0, height = 4.5, dpi = 300)
ggsave("outputs/chart_1_4_sanitation.png", plot = p1_4, width = 7.0, height = 4.5, dpi = 300)
ggsave("outputs/chart_1_5_diarrhea_drop.png", plot = p1_5, width = 7.0, height = 4.5, dpi = 300)
ggsave("outputs/chart_2_1_sanitation_association.png", plot = p2_1, width = 7.0, height = 4.5, dpi = 300)
ggsave("outputs/chart_2_2_composite_impact.png", plot = p2_2, width = 7.0, height = 4.5, dpi = 300)
ggsave("outputs/chart_community_bar_comparison.png", plot = p3_1, width = 7.5, height = 5.0, dpi = 300)

message("All portfolio charts successfully rendered and saved to outputs/!")

```
