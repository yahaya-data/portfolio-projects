---

# WASH Program Impact Evaluation: Baseline vs. Endline Performance & Community Gap Analysis

## Executive Summary

This project evaluates a paired baseline-to-endline evaluation dataset ($N=500$ paired records) across three target communities (Villages A, B, and C) to measure the impact of a comprehensive Water, Sanitation, and Hygiene (WASH) intervention. The program achieved a **$76.0%\%$ percent relative reduction in child diarrhea prevalence** (dropping from $68.4\%$ to $16.4\%$) alongside a $100\%$ transition to improved drinking water sources and a significant reduction in open defecation.

---

## Methodology & Sector Standards

Data processing, composite scoring, and visualization were executed in **RStudio**, strictly adhering to international monitoring standards:

* **WHO/UNICEF Joint Monitoring Programme (JMP) Standards:** Applied global benchmarks for primary water source classification, sanitation ladders (Open Defecation $\rightarrow$ Unimproved $\rightarrow$ Improved/VIP Latrine), and water collection proximity ($\le 30\text{-minute}$ round-trip access).
* **Composite WASH Score (0–4 Scale):** Constructed an additive compliance metric evaluating household-level adoption across four core pillars:
1. *Water Safety:* Use of an improved drinking water source.
2. *Water Access:* Round-trip collection time within target thresholds ($\le 15\text{ mins}$ one-way / $\le 30\text{ mins}$ round-trip).
3. *Hygiene:* Availability of a handwashing station equipped with both soap and water.
4. *Sanitation:* Use of an improved latrine facility (Pit Latrine or Ventilated Improved Pit).


* **Analytical Rigor:** Applied Chi-Square ($\chi^2$) association testing and community-disaggregated cross-tabulations to isolate post-intervention risk factors.

---

## Key Findings & Visualizations

### 1. Program-Wide Impact on Child Health

The cumulative adoption of WASH interventions drove a dramatic, statistically significant reduction in child diarrhea prevalence across the target population.

* **Baseline Reality:** At baseline, $91.2\%$ of households exhibited low compliance (WASH Score $0\text{–}1$), resulting in an overall child diarrhea prevalence of **$68.4\%$**.
* **Endline Transformation:** At endline, $82.8\%$ of households attained high compliance (WASH Score $3\text{–}4$), shifting the average household score from $0.57$ to $3.34$ out of $4.0$.
* **Health Outcome:** Overall child diarrhea prevalence dropped to **$16.4\%$** ($p < 0.001$).

---

### 2. Endline Community Performance & Bottleneck Analysis

While all three villages achieved substantial improvements, disaggregating endline indicators reveals critical implementation gaps in **Village C**.

* **Sanitation Gap:** Village C retains an open defecation rate of **$16.0\%$**—more than double that of Village B ($6.2\%$).
* **Hygiene Barrier:** **$12.0\%$** of households in Village C still lack any handwashing facility station.
* **Water Access Proximity:** Only **$72.0\%$** of households in Village C reached the $\le 15\text{-minute}$ fetch time target, compared to $\sim 79\%$ in Villages A and B.
* **Residual Health Burden:** Driven by these infrastructure and behavioral gaps, Village C displays a residual diarrhea prevalence of **$20.0\%$**, compared to $12.3\%$ in Village B and $16.4\%$ in Village A.

---

## Site-Specific Action Items (MEAL Recommendations)

Based on the evidence collected, **Village C is designated as the primary priority site for Post-Implementation Monitoring (PIM)** and targeted resource allocation:

1. **Behavioral Sanitation Focus (Software):** Re-trigger Community-Led Total Sanitation (CLTS) sessions in **Village C** to address the remaining $16.0\%$ open defecation rate and enforce household-level latrine construction.
2. **Hygiene Nudging & Supply Chain:** Distribute handwashing hardware (tippy-taps/soapy water containers) to the $12.0\%$ of unequipped households in Village C.
3. **Infrastructure Optimization (Hardware):** Conduct spatial mapping for secondary water distribution points in Village C to reduce travel time for the $28.0\%$ of households currently exceeding the collection target threshold.

---
