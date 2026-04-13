# QuickOrder_BigData

This repository contains the Structurizr DSL model for the QuickOrder architecture.

## Contents

- `quickorder-system-context.dsl` - Structurizr DSL workspace with:
  - C4 Level 1 System Context diagram
  - C4 Level 2 Container diagram
  - C4 Level 3 Component diagram for the Application Backend

## Overview

QuickOrder is an online restaurant ordering management platform for small restaurants and street food venues. The model captures the system context, container architecture, and backend component structure following a layered modular monolith approach.

## Usage

1. Open `quickorder-system-context.dsl` in Structurizr DSL editor or compatible tool.
2. Render the diagrams to review the system context, container view, and backend component view.

## Notes

- The backend is modeled as a single deployable container with internal components.
- External integrations include a payment provider and optional notification service.
- The frontend includes both web and mobile application clients.
