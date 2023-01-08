//
//  MainViewController.swift
//  testCompositionalLayout
//
//  Created by Даниил Ермоленко on 03.10.2022.
//

import UIKit

class MainViewController: UIViewController {
  
    // MARK: - Properties

    var collectionView: UICollectionView!
    
    let sections = Bundle.main.decode([Section].self, from: "jsonviewer.json")
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    // asdasdasdadadas
    
    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
        collectionView.register(EatingPsychologyCollectionViewCell.self, forCellWithReuseIdentifier: EatingPsychologyCollectionViewCell.reuseIdentifier)
        collectionView.register(FastingBasicsCollectionViewCell.self, forCellWithReuseIdentifier: FastingBasicsCollectionViewCell.reuseIdentifier)
        collectionView.register(HealthyEatingCollectionViewCell.self, forCellWithReuseIdentifier: HealthyEatingCollectionViewCell.reuseIdentifier)
        collectionView.register(ExplainedCollectionViewCell.self, forCellWithReuseIdentifier: ExplainedCollectionViewCell.reuseIdentifier)
        
        
        createDataSource()
        reloadData()
        print("test")
    }
    // MARK: - setupViews

    func setupViews() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    // MARK: - configure

    func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with item: Item, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        
        cell.configure(with: item)
        return cell
    }
    // MARK: - createDataSource

    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, app in
            switch self.sections[indexPath.section].header {
            case Sections.eatingPsychology:
                return self.configure(EatingPsychologyCollectionViewCell.self, with: app, for: indexPath)
            case Sections.fastingBasics:
                return self.configure(FastingBasicsCollectionViewCell.self, with: app, for: indexPath)
            case Sections.healthyEating:
                return self.configure(HealthyEatingCollectionViewCell.self, with: app, for: indexPath)
            default:
                return self.configure(ExplainedCollectionViewCell.self, with: app, for: indexPath)
            }
        }
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as? SectionHeader else {
                return UICollectionReusableView()
            }
            
            guard let firstApp = self?.dataSource?.itemIdentifier(for: indexPath) else { return UICollectionReusableView() }
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: firstApp) else { return UICollectionReusableView() }
            if section.header.isEmpty { return UICollectionReusableView() }
            
            sectionHeader.titleLabel.text = section.header
            return sectionHeader
        }
    }
    // MARK: - reloadData

    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource?.apply(snapshot)
    }
    // MARK: - createCompositionalLayout

    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = self.sections[sectionIndex]
            
            switch section.header {
            case Sections.eatingPsychology:
                return self.eatingPsychologySection(using: section)
            case Sections.fastingBasics:
                return self.fastingBasicsSection(using: section)
            case Sections.healthyEating:
                return self.healthyEatingSection(using: section)
            default:
                return self.explainedSection(using: section)
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    // MARK: - createSectionHeader

    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(80))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }
    // MARK: - makeSections

    func eatingPsychologySection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.47), heightDimension: .estimated(230))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        layoutSection.orthogonalScrollingBehavior = .continuous
        
        return layoutSection
    }

    func fastingBasicsSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.47), heightDimension: .estimated(230))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        layoutSection.orthogonalScrollingBehavior = .continuous
        
        return layoutSection
    }
    
    func healthyEatingSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.47), heightDimension: .estimated(230))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        layoutSection.orthogonalScrollingBehavior = .continuous
        
        return layoutSection
    }
    
    func explainedSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.47), heightDimension: .estimated(230))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        layoutSection.orthogonalScrollingBehavior = .continuous
        
        return layoutSection
    }
    
    
}
